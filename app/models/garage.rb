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
  scope :by_country, ->(country) { where(country: country) }
  scope :by_city, ->(city) { where(city: city) }
  scope :by_zip, ->(zip) { where(zip: zip) }
  scope :by_diameter, ->(diameter) { joins(:tyre_fees).where('tyre_fees.diameter_min <= ?', diameter).where('tyre_fees.diameter_max >= ?', diameter) }
  scope :by_price, ->(price) { joins(:tyre_fees).where('tyre_fees.price = ?', price) }
  scope :by_price_in_a_range, ->(min_price, max_price) { joins(:tyre_fees).where('price BETWEEN ? and ?', (min_price || 0), (max_price || min_price || 0)) }
  scope :by_rim, ->(rim) { joins(:tyre_fees).where('tyre_fees.rim_type = ?', TyreFee::RIM_TYPE.key(rim)) }
  scope :by_vehicle, ->(vehicle) { joins(:tyre_fees).where('tyre_fees.vehicle_type = ?', TyreFee::VEHICLE_TYPE.key(vehicle)) }

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

  def self.by_default(zip, city, country)
    garages = by_country(country)
    garages = garages.by_zip(zip) if zip
    garages = garages.by_city(city) if city
    garages
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
end
