namespace :seeds_for_each_env do

  #rake seeds_for_each_env:seeds_for_test
  desc "create basic datas for testing"
  task seeds_for_test: :environment do
    @@seeding = true
    country = 'Spain'
    country_manager = User.new
    country_manager.name = Faker::StarWars.planet.reverse.downcase.camelize
    country_manager.surname = "#{Faker::StarWars.specie}osky"
    country_manager.email = "spain_manager@123mecanico.es"
    country_manager.password  = 'Igotsomepower'
    country_manager.password_confirmation  = 'Igotsomepower'
    country_manager.role = 'country_manager'
    country_manager.country = country
    country_manager.save!

    service_list = []
    ServiceDefinition.destroy_all

    Service.all.each do |service|
      FactoryGirl.create(:demand, service_category: service.service_category, service: service)
      s1 = FactoryGirl.create(:service_definition, service: service)
      s2 = FactoryGirl.create(:service_definition, service: service)
      service_list << "#{s1.name} - #{s2.name}"
    end

    Garage.destroy_all
    addresses={0=>"Carrer de Santa Teresa, 3", 1=>"Plaça de Sant Agustí, 5", 2=>"Carrer de Salvador Giner, 12"}
    3.times do |i|
      owner = User.new
      owner.email = "garage_#{i}@123mecanico.es"
      owner.password  = 'Igotnopower'
      owner.password_confirmation  = 'Igotnopower'
      owner.role = 'owner'
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
      garage.status = 'active'
      garage.owner_id = owner.id
      garage.save!

      garage.user.update_attributes(name: Faker::Name.first_name, surname: Faker::Name.last_name)
      garage.services << Service.all
      garage.demands << Demand.all

      10.times { |j| FactoryGirl.create(:quote_proposal_with_attachments, demands_garage: garage.demands_garage[j]) }
    end

    GarageRecruitable.destroy_all
    Service.all.count.to_i.times do |i|
      FactoryGirl.create(:garage_recruitable, service_list: service_list[i])
    end
  end

  #rake seeds_for_each_env:seeds_for_prod__garages
  desc "inserts real garages"
  task seeds_for_prod__garages: :environment do
    sql = File.open("#{Rails.root}/db/sql_scripts/garages.sql").read
    sql.split(';').each do |sql_statement|
      ActiveRecord::Base.connection.execute(sql_statement)
    end
    zipcodes_normalizations = "update garage_recruitables set zip = TRIM(left(zipcode_with_city,5)) where zipcode_with_city is not null and (zip is null or zip = '');"
    cities_normalizations = "update garage_recruitables set city = TRIM(SUBSTRING(zipcode_with_city,6)) where zipcode_with_city is not null and (city is null or city = '');"
    delete_useless = "delete from garage_recruitables where email is null or email = '';"
    ActiveRecord::Base.connection.execute zipcodes_normalizations
    ActiveRecord::Base.connection.execute cities_normalizations
    ActiveRecord::Base.connection.execute delete_useless
    GarageRecruitable.fill_empty_token
  end

  #rake seeds_for_each_env:seed_for_services_definitions
  desc 'insert real services'
  task seed_for_services_definitions: :environment do
    sql = File.open("#{Rails.root}/db/sql_scripts/service_definitions.sql").read
    sql.split(';').each do |sql_statement|
      ActiveRecord::Base.connection.execute(sql_statement)
    end
  end
end