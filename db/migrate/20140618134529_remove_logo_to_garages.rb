class RemoveLogoToGarages < ActiveRecord::Migration
  def self.up
    remove_column :garages, :logo
  end

  def self.down
    add_column :garages, :logo, :string
  end
end
