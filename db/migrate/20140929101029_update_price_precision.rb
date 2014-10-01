class UpdatePricePrecision < ActiveRecord::Migration
  def up
    change_column :tyre_fees, :price, :decimal, precision: 15, scale: 2
  end

  def down
    change_column :tyre_fees, :price, :decimal, precision: 4, scale: 2
  end
end
