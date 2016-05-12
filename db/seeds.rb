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
  end
end