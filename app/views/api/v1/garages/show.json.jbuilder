json.(@garage, :id, :name, :street, :zip, :city, :email, :phone, :mobile, :fax, :latitude, :longitude, :tax_id, :website, :logo)

json.holidays do
  json.partial! 'api/v1/garages/holidays', garage: @garage
end

json.fees do
  json.partial! 'api/v1/garages/fees', garage: @garage
end

json.partial! 'api/v1/garages/timetable', garage: @garage