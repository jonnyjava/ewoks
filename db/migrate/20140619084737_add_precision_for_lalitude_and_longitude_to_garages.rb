class AddPrecisionForLalitudeAndLongitudeToGarages < ActiveRecord::Migration
  def up
    change_column :garages, :latitude,  :decimal, { precision: 9, scale: 6 }
    change_column :garages, :longitude, :decimal, { precision: 9, scale: 6 }
  end

  def down
    change_column :garages, :latitude,  :float
    change_column :garages, :longitude, :float
  end
end
