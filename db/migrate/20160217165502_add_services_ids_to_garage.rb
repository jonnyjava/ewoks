class AddServicesIdsToGarage < ActiveRecord::Migration
  def change
    add_column :garages, :service_ids, :string
  end
end
