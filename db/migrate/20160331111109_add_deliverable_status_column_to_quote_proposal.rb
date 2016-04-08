class AddDeliverableStatusColumnToQuoteProposal < ActiveRecord::Migration
  def change
    add_column :quote_proposals, :deliverable_status, :integer, default: 0
  end
end
