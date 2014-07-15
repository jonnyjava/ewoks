json.array!(garage.holidays) do |holiday|
  json.(holiday, :id, :name, :start_date, :end_date)
end