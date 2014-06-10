class RemoveValueToProperty < ActiveRecord::Migration
  def up
    remove_column :properties, :value
  end

  def down
      add_column :properties, :value, :string
  end
end
