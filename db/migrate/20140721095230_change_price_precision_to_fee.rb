class ChangePricePrecisionToFee < ActiveRecord::Migration
  def up
    change_column :fees, :price, :decimal, precision: 4, scale: 2
  end

  def down
    change_column :fees, :price, :decimal, precision: 2, scale: 0
  end
end