class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
  has_one :garage, foreign_key: "owner_id"
  enum role: [:admin, :country_manager, :owner]

  ADMIN = roles[:admin]
  COUNTRY_MANAGER = roles[:country_manager]
  OWNER = roles[:owner]

  after_initialize :set_default_role, :if => :new_record?

  def set_default_role
    self.role ||= :owner
  end

  def send_generated_password
    UserMailer.send_generated_password(self).deliver
  end
end
