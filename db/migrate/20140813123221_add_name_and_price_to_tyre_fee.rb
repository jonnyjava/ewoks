class AddNameAndPriceToTyreFee < ActiveRecord::Migration
  def change
    add_column :tyre_fees, :name, :string
    add_column :tyre_fees, :price, :decimal, precision: 4, scale: 2
  end
end
