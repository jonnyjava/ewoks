json.array!(@garages) do |garage|
  json.extract! garage, :id, :name, :street, :zip, :city, :email, :phone, :mobile, :fax, :latitude, :longitude, :tax_id, :website, :logo
  json.url garage_url(garage, format: :json)
end
