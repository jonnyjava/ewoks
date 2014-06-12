class ChangeOwnerToOwnerId < ActiveRecord::Migration
  def change
    remove_column :garages, :owner, :string
    add_column :garages, :owner_id, :integer
  end
end
