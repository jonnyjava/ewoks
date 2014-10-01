class RenameGarageColumnTownToProvince < ActiveRecord::Migration
  def change
    rename_column :garages, :town, :province
  end
end
