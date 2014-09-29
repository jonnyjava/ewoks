class AddTownToGarage < ActiveRecord::Migration
  def change
    add_column :garages, :town, :string
  end
end
