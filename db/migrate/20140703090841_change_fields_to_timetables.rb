class ChangeFieldsToTimetables < ActiveRecord::Migration
  def change
    add_column :timetables, :mon_morning_open,     :time
    add_column :timetables, :mon_morning_close,    :time
    add_column :timetables, :mon_afternoon_open,   :time
    add_column :timetables, :mon_afternoon_close,  :time
    add_column :timetables, :tue_morning_open,     :time
    add_column :timetables, :tue_morning_close,    :time
    add_column :timetables, :tue_afternoon_open,   :time
    add_column :timetables, :tue_afternoon_close,  :time
    add_column :timetables, :wed_morning_open,     :time
    add_column :timetables, :wed_morning_close,    :time
    add_column :timetables, :wed_afternoon_open,   :time
    add_column :timetables, :wed_afternoon_close,  :time
    add_column :timetables, :thu_morning_open,     :time
    add_column :timetables, :thu_morning_close,    :time
    add_column :timetables, :thu_afternoon_open,   :time
    add_column :timetables, :thu_afternoon_close,  :time
    add_column :timetables, :fri_morning_open,     :time
    add_column :timetables, :fri_morning_close,    :time
    add_column :timetables, :fri_afternoon_open,   :time
    add_column :timetables, :fri_afternoon_close,  :time
    add_column :timetables, :sat_morning_open,     :time
    add_column :timetables, :sat_morning_close,    :time
    add_column :timetables, :sat_afternoon_open,   :time
    add_column :timetables, :sat_afternoon_close,  :time
    add_column :timetables, :sun_morning_open,     :time
    add_column :timetables, :sun_morning_close,    :time
    add_column :timetables, :sun_afternoon_open,   :time
    add_column :timetables, :sun_afternoon_close,  :time

    remove_column :timetables, :day,               :integer
    remove_column :timetables, :morning_opening,   :time
    remove_column :timetables, :morning_closing,   :time
    remove_column :timetables, :afternoon_opening, :time
    remove_column :timetables, :afternoon_closing, :time
  end
end
