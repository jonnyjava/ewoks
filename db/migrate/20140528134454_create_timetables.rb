class CreateTimetables < ActiveRecord::Migration
  def change
    create_table :timetables do |t|
      t.integer :day
      t.time :morning_opening
      t.time :morning_closing
      t.time :afternoon_opening
      t.time :afternoon_closing

      t.references :garage, index: true
      t.timestamps
    end
  end
end
