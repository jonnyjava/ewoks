class RemoveTimeFieldsToHolidays < ActiveRecord::Migration
  def self.up
    remove_column :holidays, :start_time
    remove_column :holidays, :end_time
  end

  def self.down
    add_column :holidays, :start_time, :time
    add_column :holidays, :end_time, :time
  end
end
