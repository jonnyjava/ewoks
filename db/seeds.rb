@@seeding = true
country = 'Spain'

admin = User.new
admin.name = "Lord Dark Poldo II"
admin.surname = "de Poldis"
admin.email = 'admin@123mecanico.es'
admin.password  = 'Igotthepower'
admin.password_confirmation  = 'Igotthepower'
admin.role = 'admin'
admin.country = country
admin.save!

api = User.new
api.name = Faker::StarWars.planet.reverse.downcase.camelize
api.surname = "Mac #{Faker::StarWars.specie}"
api.email = "spain_api@123mecanico.es"
api.password  = 'Igotthetoken'
api.password_confirmation  = 'Igotthetoken'
api.role = 'api'
api.country = country
api.save!

country_manager = User.new
country_manager.name = Faker::StarWars.planet.reverse.downcase.camelize
country_manager.surname = "#{Faker::StarWars.specie}osky"
country_manager.email = "spain_manager@123mecanico.es"
country_manager.password  = 'Igotsomepower'
country_manager.password_confirmation  = 'Igotsomepower'
country_manager.role = 'country_manager'
country_manager.country = country
country_manager.save!

service_category_names = []
service_category_names << ["Diagnósticos",["Avería en el motor","Frenos","Bateria","Electricidad","Suspensión","Dirección","Control de emisiones","Pre-ITV","Otro diagnóstico"]]
service_category_names << ["Cambio de batería",["Sustitución de la batería"]]
service_category_names << ["Neumáticos",["Montaje","Reparación pinchazo","Permutación"]]
service_category_names << ["Cambio de aceite",["Revisión completa", "Cambio de aceite", "Liquido refrigerante"]]
service_category_names << ["Chapa y lunas",["Escobillas", "Luna", "Retrovisor", "Parachoques", "Reparacion de luna", "Reparacion de un golpe"]]
service_category_names << ["Frenado",["Pastillas de freno", "Discos de freno", "Discos y Pastillas"]]
service_category_names << ["Iluminación",["Cambio de elevalunas eléctrico", "Cambio de cierre centralizado", "Cambio de faro", "Cambio de lámpara"]]
service_category_names << ["Audio y multimedia",["Montaje amplificador", "Montaje autoradio", "Montaje altavoces", "Montaje equipo multimedia"]]
service_category_names << ["Motor",["Correa de distribucion", "Kit de distribución", "Bomba inyectora", "Inyectores", "Alternador", "Bomba de dirección", "Bomba de agua", "Embrague", "Radiador refrigerante", "Termostato", "Bujías"]]
service_category_names << ["Escapes",["Cambio de catalizador", "Cambio de escape"]]
service_category_names << ["Trenes y suspensión",["Equilibrado de ruedas", "Alineación paralelo", "Amortiguadores", "Rótulas de suspensión", "Copelas de suspensión", "Rodamientos", "Bomba de dirección", "Rótulas de dirección", "Vástago de dirección", "Fuelles de dirección", "Cremallera de dirección", "Cambio de trasmisión"]]
service_category_names << ["Aire acondicionado",["Maintenimiento aire acondicionado", "Cambio de filtro habitáculo", "Cambio de compresor", "Cambio de condensador", "Cambio evaporador", "Cambio de termostato"]]
service_category_names << ["Otros servicios",["Otros servicios"]]

service_category_names.each do |category|
  service_category = ServiceCategory.create(name: category[0])
  category[1].each do |service|
    service = Service.create(name:service, service_category: service_category)
    FactoryGirl.create(:demand, service_category: service_category, service: service)
  end
end

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

30.times do
  FactoryGirl.create(:garage_recruitable)
end
