class Garage < ActiveRecord::Base
  belongs_to :user, foreign_key: "owner_id"
  has_many :holidays
  has_one :timetable
  has_many :fees
  has_many :garage_properties
  has_many :properties, through: :garage_properties

  validates :street, :zip, :city, :country, :phone, :tax_id, presence: true
  has_attached_file :logo, default_url: "/assets/avatar_default.jpg"
  validates_attachment_content_type :logo, content_type: ['image/png', 'image/jpg']

  geocoded_by :address
  after_validation :geocode, if: :address_changed?

  ACTIVE = true
  INACTIVE = false

  scope :active, -> { where(status: ACTIVE) }
  scope :by_country, ->(country) { where(country: country) }
  scope :by_city, ->(city) { where(city: city) }
  scope :by_zip, ->(zip) { where(zip: zip) }
  scope :with_tyre_fee_less_than, ->(price) { includes(:fees).where('fees.price <= ?', price).references(:fees) }

  def address
    [street, city, zip, country].compact.join(', ')
  end

  def address_changed?
    attrs = %w(street city zip country)
    attrs.any?{|a| send "#{a}_changed?"}
  end

  def self.find_by_radius_from_location(location, radius=10)
    coords = Geocoder.coordinates(location)
    Garage.near(coords, radius, units: :km)
  end
end
