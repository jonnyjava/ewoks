class AddAttachmentDoc1ToQuoteProposals < ActiveRecord::Migration
  def self.up
    change_table :quote_proposals do |t|
      t.attachment :doc1
      t.attachment :doc2
      t.attachment :doc3
      remove_column :quote_proposals, :attached_docs
    end
  end

  def self.down
    add_column :quote_proposals, :attached_docs, :string
    remove_attachment :quote_proposals, :doc1
    remove_attachment :quote_proposals, :doc2
    remove_attachment :quote_proposals, :doc3
  end
end
