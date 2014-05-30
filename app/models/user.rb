class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
  Roles = [ :admin , :country_manager, :owner ]

  def is?( requested_role )
    self.role == requested_role.to_s
  end
end
