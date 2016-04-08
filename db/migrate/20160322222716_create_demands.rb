class CreateDemands < ActiveRecord::Migration
  def change
    create_table :demands do |t|
      t.string :city
      t.references :service_category, index: true
      t.references :service, index: true
      t.string :vin_number
      t.string :brand
      t.string :model
      t.string :year
      t.string :engine
      t.string :engine_letters
      t.string :name_and_surnames
      t.string :phone
      t.string :email
      t.boolean :wants_newsletter
      t.boolean :accepts_privacy
      t.text :comments
      t.text :demand_details

      t.timestamps null: false
    end
    add_foreign_key :demands, :service_categories
    add_foreign_key :demands, :services
  end
end
