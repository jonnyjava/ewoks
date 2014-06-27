class ChangeLatitudeAndLongitudeTypeInGarages < ActiveRecord::Migration
  def up
    change_column :garages, :latitude, :float
    change_column :garages, :longitude, :float
  end

  def down
    change_column :garages, :latitude, :integer
    change_column :garages, :longitude, :integer
  end
end
