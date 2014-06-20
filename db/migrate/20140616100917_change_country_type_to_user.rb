class ChangeCountryTypeToUser < ActiveRecord::Migration
  def up
    change_column :users, :country, :string
  end

  def down
    change_column :users, :country, :integer
  end
end
