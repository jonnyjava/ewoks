class AddFeeIdToTyreFee < ActiveRecord::Migration
  def change
    add_column :tyre_fees, :fee_id, :integer
  end
end
