admin = User.new
admin.email = 'admin@norauto.com'
admin.password  = "Igotthepower"
admin.password_confirmation  = "Igotthepower"
admin.role = User::ADMIN
admin.country = "Spain"
admin.save!

country_manager = User.new
country_manager.email = 'country_manager@norauto.com'
country_manager.password  = "Igotsomepower"
country_manager.password_confirmation  = "Igotsomepower"
country_manager.role = User::COUNTRY_MANAGER
country_manager.country = "Spain"
country_manager.save!

owner = User.new
owner.email = 'owner@norauto.com'
owner.password  = "Igotnopower"
owner.password_confirmation  = "Igotnopower"
owner.role = User::OWNER
owner.country = "Spain"
owner.save!

api = User.new
api.email = 'api@norauto.com'
api.password  = "Igotthetoken"
api.password_confirmation  = "Igotthetoken"
api.role = User::API
api.country = "Spain"
api.save!

garage = Garage.new
garage.name = "Norauto Valencia"
garage.street = "Calle cuenca"
garage.zip = "46007"
garage.city = "Valencia"
garage.email = "fake@email.com"
garage.phone = "666 666 666"
garage.tax_id = "999888777666123"
garage.country = "Spain"
garage.owner_id = owner.id
garage.timetable = Timetable.new
garage.save!