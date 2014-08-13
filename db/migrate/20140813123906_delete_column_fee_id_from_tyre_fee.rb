class DeleteColumnFeeIdFromTyreFee < ActiveRecord::Migration
  def self.up
    remove_column :tyre_fees, :fee_id
  end

  def self.down
    add_column :tyre_fees, :fee_id, :integer
  end
end
