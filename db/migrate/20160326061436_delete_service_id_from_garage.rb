class DeleteServiceIdFromGarage < ActiveRecord::Migration
    def self.up
    remove_column :garages, :service_ids
  end

  def self.down
    add_column :garages, :service_ids, :string
  end
end
