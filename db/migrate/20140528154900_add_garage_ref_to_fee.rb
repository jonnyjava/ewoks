class AddGarageRefToFee < ActiveRecord::Migration
  def change
    add_reference :fees, :garage, index: true
  end
end
