class AddColumnDemandsGarageIdToQuoteProposal < ActiveRecord::Migration
  def change
    add_reference :quote_proposals, :demands_garage, index: true
    add_foreign_key :quote_proposals, :demands_garages
  end
end
