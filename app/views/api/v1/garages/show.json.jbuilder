json.(@garage, :id, :name, :street, :zip, :province, :city, :email, :phone, :mobile, :fax, :latitude, :longitude, :tax_id, :website, :logo)

json.holidays do
  json.partial! 'api/v1/garages/holidays', garage: @garage
end

json.partial! 'api/v1/garages/timetable', garage: @garage

json.tyre_fees do
  json.array!(@garage.tyre_fees) do |tyre_fee|
    json.(tyre_fee, :name, :price, :vehicle_type, :diameter_min, :diameter_max, :rim_type)
  end
end
