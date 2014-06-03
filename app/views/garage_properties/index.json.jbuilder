json.array!(@garage_properties) do |garage_property|
  json.extract! garage_property, :id, :value, :garage_id, :property_id
  json.url garage_property_url(garage_property, format: :json)
end
