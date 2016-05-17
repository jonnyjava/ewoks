class CreateServiceDefinitions < ActiveRecord::Migration
  def change
    create_table :service_definitions do |t|
      t.string :name
      t.references :service, index: true

      t.timestamps null: false
    end
    add_foreign_key :service_definitions, :services
  end
end
