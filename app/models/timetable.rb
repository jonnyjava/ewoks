class Timetable < ActiveRecord::Base
  belongs_to :garage

  def closes_at_noon(day_name)
    send("#{day_name.downcase[0, 3]}_morning_close".to_sym).blank?
  end
end