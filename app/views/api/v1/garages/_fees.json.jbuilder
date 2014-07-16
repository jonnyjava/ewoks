json.array!(garage.fees) do |fee|
  json.(fee, :id, :name, :price)
end