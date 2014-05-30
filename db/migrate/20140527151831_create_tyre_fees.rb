class CreateTyreFees < ActiveRecord::Migration
  def change
    create_table :tyre_fees do |t|
      t.integer :vehicle_type
      t.integer :diameter_min
      t.integer :diameter_max
      t.integer :rim_type

      t.timestamps
    end
  end
end
