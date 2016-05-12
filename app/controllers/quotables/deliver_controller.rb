module Quotables
  class DeliverController < ApplicationController
    before_action :set_quote_proposal, only: :update
    after_action :verify_authorized

    def update
      authorize @quote_proposal
      @quote_proposal.send_to_contact
      @quote_proposal.delivered!
      redirect_to quote_proposals_path
    end

    def set_quote_proposal
      @quote_proposal = QuoteProposal.find(secure_id)
    end

    def secure_id
      params[:id].to_i
    end
  end
end
