json.array!(@holidays) do |holiday|
  json.extract! holiday, :id, :start_date, :end_date, :start_time, :end_time
  json.url holiday_url(holiday, format: :json)
end
