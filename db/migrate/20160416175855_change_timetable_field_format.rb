class ChangeTimetableFieldFormat < ActiveRecord::Migration
  def up
    change_column :timetables, :mon_morning_open, :string
    change_column :timetables, :mon_morning_close, :string
    change_column :timetables, :mon_afternoon_open, :string
    change_column :timetables, :mon_afternoon_close, :string
    change_column :timetables, :tue_morning_open, :string
    change_column :timetables, :tue_morning_close, :string
    change_column :timetables, :tue_afternoon_open, :string
    change_column :timetables, :tue_afternoon_close, :string
    change_column :timetables, :wed_morning_open, :string
    change_column :timetables, :wed_morning_close, :string
    change_column :timetables, :wed_afternoon_open, :string
    change_column :timetables, :wed_afternoon_close, :string
    change_column :timetables, :thu_morning_open, :string
    change_column :timetables, :thu_morning_close, :string
    change_column :timetables, :thu_afternoon_open, :string
    change_column :timetables, :thu_afternoon_close, :string
    change_column :timetables, :fri_morning_open, :string
    change_column :timetables, :fri_morning_close, :string
    change_column :timetables, :fri_afternoon_open, :string
    change_column :timetables, :fri_afternoon_close, :string
    change_column :timetables, :sat_morning_open, :string
    change_column :timetables, :sat_morning_close, :string
    change_column :timetables, :sat_afternoon_open, :string
    change_column :timetables, :sat_afternoon_close, :string
    change_column :timetables, :sun_morning_open, :string
    change_column :timetables, :sun_morning_close, :string
    change_column :timetables, :sun_afternoon_open, :string
    change_column :timetables, :sun_afternoon_close, :string
  end

  def down
    change_column :timetables, :mon_morning_open, :time
    change_column :timetables, :mon_morning_close, :time
    change_column :timetables, :mon_afternoon_open, :time
    change_column :timetables, :mon_afternoon_close, :time
    change_column :timetables, :tue_morning_open, :time
    change_column :timetables, :tue_morning_close, :time
    change_column :timetables, :tue_afternoon_open, :time
    change_column :timetables, :tue_afternoon_close, :time
    change_column :timetables, :wed_morning_open, :time
    change_column :timetables, :wed_morning_close, :time
    change_column :timetables, :wed_afternoon_open, :time
    change_column :timetables, :wed_afternoon_close, :time
    change_column :timetables, :thu_morning_open, :time
    change_column :timetables, :thu_morning_close, :time
    change_column :timetables, :thu_afternoon_open, :time
    change_column :timetables, :thu_afternoon_close, :time
    change_column :timetables, :fri_morning_open, :time
    change_column :timetables, :fri_morning_close, :time
    change_column :timetables, :fri_afternoon_open, :time
    change_column :timetables, :fri_afternoon_close, :time
    change_column :timetables, :sat_morning_open, :time
    change_column :timetables, :sat_morning_close, :time
    change_column :timetables, :sat_afternoon_open, :time
    change_column :timetables, :sat_afternoon_close, :time
    change_column :timetables, :sun_morning_open, :time
    change_column :timetables, :sun_morning_close, :time
    change_column :timetables, :sun_afternoon_open, :time
    change_column :timetables, :sun_afternoon_close, :time
  end
end
