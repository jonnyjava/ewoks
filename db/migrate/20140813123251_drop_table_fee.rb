class DropTableFee < ActiveRecord::Migration
  def up
  	drop_table :fees
  end

  def down
  	 create_table :fees do |t|
      t.string :name
      t.decimal :price

      t.timestamps
    end
  end
end
