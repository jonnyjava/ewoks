class ChangeStatusToGarage < ActiveRecord::Migration
  def change
    change_column :garages, :status, :integer, default: -1
  end
end
