class Garage < ActiveRecord::Base
  belongs_to :user, foreign_key: 'owner_id'
  has_many :holidays, dependent: :destroy
  has_one :timetable, dependent: :destroy
  has_many :tyre_fees, dependent: :destroy
  has_many :quote_proposals, dependent: :destroy
  has_and_belongs_to_many :services
  has_many :demands_garage
  has_many :demands, through: :demands_garage
  before_destroy { services.clear }

  validates :name, :street, :zip, :country, :phone, :tax_id, presence: true
  validates :email, uniqueness: true
  has_attached_file :logo
  validates_attachment_content_type :logo, content_type: %w(image/png image/jpeg)

  geocoded_by :address
  after_validation :geocode, if: :address_changed?
  after_save :notify_my_owner, if: :status_changed?
  after_create :send_signup_confirmation, :create_my_timetable

  enum status: [ :inactive, :to_confirm, :active ]

  scope :by_country, ->(country) { where(country: country) if country }
  scope :by_city, ->(city) { where(city: city) if city }
  scope :by_zip, ->(zip) { where(zip: zip) if zip }
  scope :by_tyre_fee, -> { joins(:tyre_fees) }
  scope :by_price, ->(price) { by_tyre_fee.merge(TyreFee.by_price(price)) if price }
  scope :by_rim, ->(rim) { by_tyre_fee.merge(TyreFee.by_rim(rim)) if rim }
  scope :by_vehicle, ->(vehicle) { by_tyre_fee.merge(TyreFee.by_vehicle(vehicle)) if vehicle }
  scope :by_diameter, ->(diameter) { by_tyre_fee.merge(TyreFee.by_diameter(diameter)) if diameter }
  scope :by_price_in_a_range, ->(min_price, max_price) { by_tyre_fee.merge(TyreFee.by_price_in_a_range(min_price, max_price)) }
  scope :by_date, ->(date) { joins(:holidays).merge(Holiday.not_in_holiday(date)) if date }
  scope :by_status, ->(status) { where(status: statuses[status]) if status }
  scope :by_service, ->(service_id) { Garage.includes(:services).where( services: { id: service_id } ) }

  def address
    [street, province, city, zip, country].compact.join(', ')
  end

  def address_changed?
    attrs = %w(street province city zip country)
    attrs.any? { |a| send "#{a}_changed?" }
  end

  def assign_services(assignable_services)
    services << assignable_services
  end

  def create_my_owner
    owner = User.create(email: email, password: Faker::Internet.password(10))
    update_attribute(:owner_id, owner.id)
    UserMailer.send_generated_password(owner).deliver_now
  end

  def create_my_timetable
    return if self.timetable
    Timetable.create(garage: self)
  end

  def toggle_status
    active? ? inactive! : active! unless to_confirm?
  end

  def notify_my_owner
    return unless user
    UserMailer.send_changed_status_notification(user).deliver_now if !user.garage.to_confirm?
  end

  def send_signup_confirmation
    PublicFormMailer.signup_confirmation(self).deliver_now
  end

  def signup_verification_token
    token = [email, status, created_at, ENV['AUTH_TOKENIZER']].join
    Digest::SHA1.hexdigest(token)
  end

  def unanswered_demands
    demands.includes(:demands_garage).where('demands_garages.quote_proposal_id is null')
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
    Garage.by_status('to_confirm').each do |g|
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

  def self.assignable_garages(demand)
    by_service(demand.service_id).find_by_radius_from_location(demand.city)
  end
end
