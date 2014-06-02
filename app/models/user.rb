class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
  ADMIN = 0
  COUNTRY_MANAGER = 1
  OWNER = 2
  ROLES = {admin: ADMIN, country_manager: COUNTRY_MANAGER, owner: OWNER}

  def is?( requested_role )
    self.role == ROLES[requested_role]
  end
end
