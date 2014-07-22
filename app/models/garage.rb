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
  after_create :send_signup_confirmation

  ACTIVE = 1
  INACTIVE = 0
  TO_BE_CONFIRMED = -1

  scope :active, -> { where(status: ACTIVE) }
  scope :to_confirm, -> { where(status: TO_BE_CONFIRMED) }
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

  def disable!
    self.update_attribute(:status, INACTIVE)
  end

  def create_my_owner
    owner = User.create(email: email, password: Faker::Internet::password(10))
    self.update_attribute(:owner_id, owner.id)
  end

  def send_signup_confirmation
    PublicFormMailer.sing_up_confirmation(self).deliver
  end

  def signup_verification_token
      Digest::SHA1.hexdigest([email, status, 'endor is full of ewoks'].join)
  end

  def self.find_by_radius_from_location(location, radius=10)
    coords = Geocoder.coordinates(location)
    Garage.near(coords, radius, units: :km)
  end

  def self.find_by_signup_verification_token(token)
    garage = nil
    Garage.to_confirm.each do |g|
      if g.signup_verification_token == token
        garage = g
        break
      end
    end
    garage
  end
end
