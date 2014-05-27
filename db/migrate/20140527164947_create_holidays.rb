class CreateHolidays < ActiveRecord::Migration
  def change
    create_table :holidays do |t|
      t.date :start_date
      t.date :end_date
      t.time :start_time
      t.time :end_time

      t.timestamps
    end
  end
end
