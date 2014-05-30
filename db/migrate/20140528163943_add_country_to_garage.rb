class AddCountryToGarage < ActiveRecord::Migration
  def change
    add_column :garages, :country, :string
  end
end
