class AlterTableQuoteProposal < ActiveRecord::Migration
  def self.up
    change_column :quote_proposals, :ttc_price,  :decimal, precision: 8, scale: 2
  end

  def self.down
    change_column :quote_proposals, :ttc_price,  :integer
  end
end
