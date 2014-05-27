class CreateGarages < ActiveRecord::Migration
  def change
    create_table :garages do |t|
      t.string :name
      t.string :owner
      t.string :addres
      t.string :zip
      t.string :city
      t.string :email
      t.string :phone
      t.string :mobile
      t.string :fax
      t.integer :latitude
      t.integer :longitude
      t.string :tax_id
      t.string :website
      t.string :logo

      t.timestamps
    end
  end
end
