class CreateQuoteProposals < ActiveRecord::Migration
  def change
    create_table :quote_proposals do |t|
      t.belongs_to :garage, index: true
      t.belongs_to :demand, index: true
      t.text :proposal
      t.text :attached_docs
      t.integer :ttc_price
      t.date :expiration
      t.integer :status

      t.timestamps null: false
    end
    add_foreign_key :quote_proposals, :garages
    add_foreign_key :quote_proposals, :demands
  end
end
