json.array!(@holidays) do |holiday|
  json.extract! holiday, :id, :name, :start_date, :end_date, :start_time, :end_time, :garage_id
  json.url holiday_url(holiday, format: :json)
end
