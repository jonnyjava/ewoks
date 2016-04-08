module Quotables
  class DeliverController < ApplicationController
    before_action :set_quote_proposal, only: :update
    after_action :verify_authorized

    def update
      authorize @quote_proposal
      @quote_proposal.delivered!
      @quote_proposal.send_to_contact
      redirect_to quote_proposals_path
    end

    def set_quote_proposal
      @quote_proposal = QuoteProposal.find(params[:id])
    end
  end
end
