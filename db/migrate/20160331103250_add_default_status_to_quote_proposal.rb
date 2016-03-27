class AddDefaultStatusToQuoteProposal < ActiveRecord::Migration
  def up
    change_column :quote_proposals, :status, :integer, default: 0
  end

  def down
    change_column :quote_proposals, :status, :integer, default: nil
  end
end
