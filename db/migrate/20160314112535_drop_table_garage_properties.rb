class DropTableGarageProperties < ActiveRecord::Migration
  def up
    drop_table :properties
    drop_table :garage_properties
  end

  def down
    create_table :properties do |t|
      t.string :name
      t.string :type
      t.string :value

      t.timestamps
    end
    create_table :garage_properties do |t|
      t.string :value
      t.references :garage, index: true
      t.references :property, index: true

      t.timestamps
    end
  end
end
