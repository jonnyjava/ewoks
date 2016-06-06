class AddIconToServiceCategory < ActiveRecord::Migration
  def change
    add_column :service_categories, :icon, :string
  end
end
