class AddGarageIdToTyreFee < ActiveRecord::Migration
  def change
    add_column :tyre_fees, :garage_id, :integer
  end
end
