json.timetable do |json|
  if garage.timetable
    json.(garage.timetable)
    Date::DAYNAMES.each do |day|
      %w(morning_open morning_close afternoon_open afternoon_close).each do |day_part|
        field = "#{day.downcase[0, 3]}_#{day_part}"
        horary = garage.timetable.send(field)
        json.set!(field, horary.strftime("%H:%M")) if horary.present?
      end
    end
  end
end
