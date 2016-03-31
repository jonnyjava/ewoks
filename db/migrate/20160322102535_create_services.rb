class CreateServices < ActiveRecord::Migration
  def change
    create_table :services do |t|
      t.string :name
      t.references :service_category, index: true

      t.timestamps null: false
    end
    add_foreign_key :services, :service_categories
  end
end
