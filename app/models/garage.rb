class Garage < ActiveRecord::Base
  belongs_to :user, foreign_key: 'owner_id'
  has_many :holidays
  has_one :timetable
  has_many :tyre_fees
  has_many :garage_properties
  has_many :properties, through: :garage_properties

  validates :street, :zip, :city, :country, :phone, :tax_id, presence: true
  validates :email, uniqueness: true
  has_attached_file :logo, default_url: '/assets/avatar_default.jpg'
  validates_attachment_content_type :logo, content_type: %w(image/png image/jpg)

  geocoded_by :address
  after_validation :geocode, if: :address_changed?
  after_save :notify_my_owner, if: :status_changed?
  after_create :send_signup_confirmation

  ACTIVE = 1
  INACTIVE = 0
  TO_BE_CONFIRMED = -1
  COUNTRIES = %w(Italy Poland Portugal Argentina France Spain Belgium)

  scope :active, -> { where(status: ACTIVE) }
  scope :to_confirm, -> { where(status: TO_BE_CONFIRMED) }
  scope :by_country, ->(country) { where(country: country) if country }
  scope :by_city, ->(city) { where(city: city) if city}
  scope :by_zip, ->(zip) { where(zip: zip) if zip}
  scope :by_tyre_fee, -> { joins(:tyre_fees) }
  scope :by_price, ->(price) { by_tyre_fee.merge(TyreFee.by_price(price)) if price }
  scope :by_rim, ->(rim) { by_tyre_fee.merge(TyreFee.by_rim(rim)) if rim }
  scope :by_vehicle, ->(vehicle) { by_tyre_fee.merge(TyreFee.by_vehicle(vehicle)) if vehicle }
  scope :by_diameter, ->(diameter) { by_tyre_fee.merge(TyreFee.by_diameter(diameter)) if diameter }
  scope :by_price_in_a_range, ->(min_price, max_price) { by_tyre_fee.merge(TyreFee.by_price_in_a_range(min_price, max_price)) }
  scope :by_date, ->(date) { joins(:holidays).merge(Holiday.not_in_holiday(date)) if date }

  def address
    [street, city, zip, country].compact.join(', ')
  end

  def address_changed?
    attrs = %w(street city zip country)
    attrs.any? { |a| send "#{a}_changed?" }
  end

  def inactive!
    update_attribute(:status, INACTIVE)
  end

  def active!
    update_attribute(:status, ACTIVE)
  end

  def active?
    status == ACTIVE
  end

  def inactive?
    status == INACTIVE
  end

  def to_be_confirmed?
    status == TO_BE_CONFIRMED
  end

  def create_my_owner
    owner = User.create(email: email, password: Faker::Internet.password(10))
    update_attribute(:owner_id, owner.id)
    UserMailer.send_generated_password(owner).deliver
  end

  def notify_my_owner
    return unless user
    UserMailer.send_activation_notification(user).deliver if active?
  end

  def send_signup_confirmation
    PublicFormMailer.signup_confirmation(self).deliver
  end

  def signup_verification_token
    token = [email, status, created_at, 'endor is full of ewoks'].join
    Digest::SHA1.hexdigest(token)
  end

  def self.by_default(zip, city)
    by_city(city).by_zip(zip).by_tyre_fee
  end

  def self.find_by_radius_from_location(location, radius = 10)
    coords = Geocoder.coordinates(location)
    Garage.near(coords, radius, units: :km)
  end

  def self.find_by_signup_verification_token(token)
    garage = nil
    Garage.to_confirm.each do |g|
      next unless g.signup_verification_token == token
      garage = g
      break
    end
    garage
  end

  def self.countries(user)
    return [user.country] if user && !user.admin?
    COUNTRIES
  end

  def self.garages_without_holidays
    Garage.where.not(id: Holiday.pluck(:garage_id))
  end

  def self.opened_at(date)
    garages_opened = Garage.garages_without_holidays
    garage_with_holidays_opened = Garage.by_date(date)
    garage_with_holidays_opened | garages_opened
  end
end