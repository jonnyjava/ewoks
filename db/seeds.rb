admin = User.new
admin.email = 'admin@123mecanico.es'
admin.password  = 'Igotthepower'
admin.password_confirmation  = 'Igotthepower'
admin.role = User::ADMIN
admin.country = 'Spain'
admin.save!


COUNTRIES.each do |country|

  api = User.new
  api.email = "#{country}_api@123mecanico.es"
  api.password  = 'Igotthetoken'
  api.password_confirmation  = 'Igotthetoken'
  api.role = User::API
  api.country = country
  api.save!

  country_manager = User.new
  country_manager.email = "#{country}_manager@123mecanico.es"
  country_manager.password  = 'Igotsomepower'
  country_manager.password_confirmation  = 'Igotsomepower'
  country_manager.role = User::COUNTRY_MANAGER
  country_manager.country = country
  country_manager.save!

  3.times do |i|
    owner = User.new
    owner.email = "#{country}_#{i}_owner@123mecanico.es"
    owner.password  = 'Igotnopower'
    owner.password_confirmation  = 'Igotnopower'
    owner.role = User::OWNER
    owner.country = country
    owner.save!

    garage = Garage.new
    garage.name = "Garage #{country} #{i}"
    garage.street = "#{country} road"
    garage.zip = "#{46000 + i}"
    garage.city = 'Valencia'
    garage.province = 'Valencia'
    garage.email = "fake_#{i}_#{country}@email.com"
    garage.phone = '666 666 666'
    garage.tax_id = '999888777666123'
    garage.country = country
    garage.status = Garage::ACTIVE
    garage.owner_id = owner.id
    garage.timetable = Timetable.new
    garage.save!

    multiplier = 1
    TyreFee::VEHICLES.each do |vehicle|
      TyreFee::RIMS.each do |rim|
        tyre_fee = garage.tyre_fees.build
        tyre_fee.name = "TyreFee for #{vehicle} with #{rim} rims"
        tyre_fee.price = 5 * multiplier
        tyre_fee.rim_type = TyreFee::RIM_TYPE.key(rim)
        tyre_fee.diameter_min = 10
        tyre_fee.diameter_max = 30
        tyre_fee.vehicle_type = TyreFee::VEHICLE_TYPE.key(vehicle)
        tyre_fee.save!
        multiplier += 1
      end
    end
  end
end
