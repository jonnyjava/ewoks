class AddQuoteProposalIdColumnToDemandsGarages < ActiveRecord::Migration
  def change
    add_reference :demands_garages, :quote_proposal, index: true
  end
end
