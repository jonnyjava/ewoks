module API
  module V1
    class QuoteProposalsController < ApplicationController
      include TokenAuthenticationForApiControllers

      protect_from_forgery except: [:update]
      skip_before_filter :authenticate_user!
      before_action :authenticate, :set_quote_proposal

      def show
        head :unprocessable_entity and return unless @quote_proposal
      end

      def update
        head :unprocessable_entity and return unless @quote_proposal

        status = quote_proposal_params[:status]
        head :unprocessable_entity and return unless @quote_proposal.can_accept?(status)

        if @quote_proposal.update(status: status)
          respond_according_to_status
        else
          head :bad_request
        end
      end

    private

      def respond_according_to_status
        @quote_proposal.reload
        if @quote_proposal.refused?
          render json: {}
        else
          render 'garage_sheet'
        end
      end

      def set_quote_proposal
        @quote_proposal = QuoteProposal.find_by_mail_token(quote_proposal_params[:token])
        return unless @quote_proposal
        @quote_proposal = @quote_proposal.decorate
      end

      def quote_proposal_params
        params.permit(:token, :status)
      end
    end
  end
end
