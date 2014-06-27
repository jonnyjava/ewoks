class ChangePriceToFee < ActiveRecord::Migration
  def up
    change_column :fees, :price, :decimal, precision: 2
  end

  def down
    change_column :fees, :price, :decimal, precision: 10, scale: 0
  end
end
