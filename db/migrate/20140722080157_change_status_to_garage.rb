class ChangeStatusToGarage < ActiveRecord::Migration
  def change
    remove_column :garages, :status
    add_column :garages, :status, :integer, default: -1
  end
end
