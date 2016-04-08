class AddMailTokenColumnToQuoteProposal < ActiveRecord::Migration
  def change
    add_column :quote_proposals, :mail_token, :string
    add_index :quote_proposals, :mail_token
  end
end
