json.array!(@garages) do |garage|
  json.(garage, :id, :name, :latitude, :longitude, :street, :zip, :city, :email, :phone, :mobile, :fax, :website, :logo_file_name)

  garage_tyre_fees = @tyre_fees.select { |tyre_fee| tyre_fee.garage_id == garage.id }
  json.tyre_fees do
    json.partial! 'api/v1/garages/tyre_fees', tyre_fees: garage_tyre_fees
  end

  json.partial! 'api/v1/garages/timetable', garage: garage
end
