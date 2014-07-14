json.array!(@garages) do |garage|
  json.(garage, :id, :name, :latitude, :longitude, :street, :zip, :city)

  json.fees do
    json.partial! 'api/garages/fees', garage: garage
  end

  json.partial! 'api/garages/timetable', garage: garage
end
