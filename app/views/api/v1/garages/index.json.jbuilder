json.array!(@garages) do |garage|
  json.(garage, :id, :name, :latitude, :longitude, :street, :zip, :city)

  json.tyre_fees do
    json.partial! 'api/v1/garages/tyre_fees', garage: garage
  end

  json.partial! 'api/v1/garages/timetable', garage: garage
end
