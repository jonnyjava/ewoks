class RenameColumnAddressByStreetToGarages < ActiveRecord::Migration
  def change
    rename_column :garages, :address, :street
  end
end
