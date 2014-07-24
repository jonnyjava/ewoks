class ChangeGarageStatusDefaultValue < ActiveRecord::Migration
  def change
    change_column :garages, :status, :boolean, default: false
  end
end
