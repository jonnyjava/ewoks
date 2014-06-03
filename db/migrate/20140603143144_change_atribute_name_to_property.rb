class ChangeAtributeNameToProperty < ActiveRecord::Migration
  def change
    rename_column :properties, :type, :type_of
  end
end
