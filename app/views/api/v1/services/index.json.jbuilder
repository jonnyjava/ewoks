json.array!(@service_categories) do |service_category|
  json.service_category do
    json.id service_category.id
    json.name service_category.name
    json.icon service_category.icon

    json.services service_category.services do |service|
      json.id service.id
      json.name service.name
      json.service_definitions service.service_definitions.map(&:name).join(', ')
    end
  end
end
