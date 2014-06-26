json.array!(@tyre_fees) do |tyre_fee|
  json.extract! tyre_fee, :id
  json.url garage_tyre_fee_url(tyre_fee, format: :json)
end
