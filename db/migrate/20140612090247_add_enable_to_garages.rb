class AddEnableToGarages < ActiveRecord::Migration
  def change
    add_column :garages, :enable, :boolean
  end
end
