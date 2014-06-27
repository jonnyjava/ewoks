class CreateGarageProperties < ActiveRecord::Migration
  def change
    create_table :garage_properties do |t|
      t.string :value
      t.references :garage, index: true
      t.references :property, index: true

      t.timestamps
    end
  end
end
