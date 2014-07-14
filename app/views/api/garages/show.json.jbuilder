json.(@garage, :id, :name, :street, :zip, :city, :email, :phone, :mobile, :fax, :latitude, :longitude, :tax_id, :website, :logo)

json.holidays do
  json.partial! 'api/garages/holidays', garage: @garage
end

json.fees do
  json.partial! 'api/garages/fees', garage: @garage
end

json.partial! 'api/garages/timetable', garage: @garage