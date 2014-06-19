class ChangeEnableToStatusInGarages < ActiveRecord::Migration
  def change
    rename_column :garages, :enable, :status
  end
end
