class User < ActiveRecord::Base
  before_create :set_auth_token
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
  has_one :garage, foreign_key: 'owner_id', dependent: :destroy
  enum role: [:admin, :country_manager, :owner, :api]

  ADMIN = roles[:admin]
  COUNTRY_MANAGER = roles[:country_manager]
  OWNER = roles[:owner]
  API = roles[:api]

  after_initialize :set_default_role, if: :new_record?
  after_initialize :set_default_country, if: :new_record?

  def set_default_role
    self.role ||= :owner
  end

  def set_default_country
    self.country ||= 'Spain'
  end

  def update_auth_token
    self.auth_token = generate_auth_token
  end

  def full_name
    "#{name} #{surname}"
  end

  def demands
    garage.demands.page
  end

  private

  def set_auth_token
    return if auth_token.present?
    self.auth_token = generate_auth_token
  end

  def generate_auth_token
    loop do
      token = SecureRandom.hex
      break token unless self.class.exists?(auth_token: token)
    end
  end
end
