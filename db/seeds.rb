user = User.new
user.email = 'admin@norauto.com'
user.password  = "Igotthepower"
user.password_confirmation  = "Igotthepower"
user.role = User::ADMIN
user.country = "Spain"
user.save!

user = User.new
user.email = 'country_manager@norauto.com'
user.password  = "Igotsomepower"
user.password_confirmation  = "Igotsomepower"
user.role = User::COUNTRY_MANAGER
user.country = "Spain"
user.save!

user = User.new
user.email = 'owner@norauto.com'
user.password  = "Igotnopower"
user.password_confirmation  = "Igotnopower"
user.role = User::OWNER
user.country = "Spain"
user.save!

user = User.new
user.email = 'api@norauto.com'
user.password  = "Igotthetoken"
user.password_confirmation  = "Igotthetoken"
user.role = User::API
user.country = "Spain"
user.save!
