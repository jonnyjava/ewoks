json.array!(@properties) do |property|
  json.extract! property, :id, :name, :type_of
  json.url property_url(property, format: :json)
end
