json.array!(tyre_fees) do |tyre_fee|
  json.(tyre_fee, :id, :name, :price)
end