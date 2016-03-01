country = 'Spain'

admin = User.new
admin.email = 'admin@123mecanico.es'
admin.password  = 'Igotthepower'
admin.password_confirmation  = 'Igotthepower'
admin.role = User::ADMIN
admin.country = country
admin.save!

api = User.new
api.email = "spain_api@123mecanico.es"
api.password  = 'Igotthetoken'
api.password_confirmation  = 'Igotthetoken'
api.role = User::API
api.country = country
api.save!

country_manager = User.new
country_manager.email = "spain_manager@123mecanico.es"
country_manager.password  = 'Igotsomepower'
country_manager.password_confirmation  = 'Igotsomepower'
country_manager.role = User::COUNTRY_MANAGER
country_manager.country = country
country_manager.save!

addresses={0=>"Carrer de Santa Teresa, 3", 1=>"Plaça de Sant Agustí, 5", 2=>"Carrer de Salvador Giner, 12"}

3.times do |i|
  owner = User.new
  owner.email = "garage_#{i}@123mecanico.es"
  owner.password  = 'Igotnopower'
  owner.password_confirmation  = 'Igotnopower'
  owner.role = User::OWNER
  owner.country = country
  owner.save!

  garage = Garage.new
  garage.name = "Garage spain #{i}"
  garage.street = addresses[i]
  garage.zip = "#{46001 + i}"
  garage.city = 'Valencia'
  garage.province = 'Valencia'
  garage.email = "#{i}_#{owner.email}"
  garage.phone = '666 666 666'
  garage.tax_id = '999888777666123'
  garage.country = country
  garage.status = Garage::ACTIVE
  garage.owner_id = owner.id
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

25.times do |i|
  garage_recruitable = FactoryGirl.create(:recruitable)
end
