class Timetable < ActiveRecord::Base
  belongs_to :garage

  DAYS = ["Monday", "Tuesday", "Wednesday", "Thursday", "Friday", "Saturday", "Sunday"]
end
