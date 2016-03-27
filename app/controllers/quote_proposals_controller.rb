class QuoteProposalsController < ApplicationController
  before_action :set_quote_proposal, only: [:show, :edit, :update, :destroy]
  after_action :verify_authorized

  def index
    quote_proposals = policy_scope(QuoteProposal.all.order([status: :asc, updated_at: :desc]).page(params[:page]))
    authorize quote_proposals
    @quote_proposals = QuoteProposalDecorator.decorate_collection(quote_proposals)
  end

  def show
    authorize @quote_proposal
  end

  def new
    @quote_proposal = QuoteProposal.new(new_quote_proposal_params)
    authorize @quote_proposal
  end

  def edit
    authorize @quote_proposal
  end

  def create
    @quote_proposal = QuoteProposal.new(quote_proposal_params)
    authorize @quote_proposal
    if @quote_proposal.save
      redirect_to @quote_proposal
    else
      render :new
    end
  end

  def update
    authorize @quote_proposal
    update_params = set_price(quote_proposal_params)
    if @quote_proposal.update(update_params)
      redirect_to @quote_proposal
    else
      render :edit
    end
  end

  def destroy
    authorize @quote_proposal
    @quote_proposal.destroy
    redirect_to quote_proposals_path
  end

  private
    def set_quote_proposal
      @quote_proposal = QuoteProposal.find(params[:id]).decorate
    end

    def quote_proposal_params
      params.require(:quote_proposal).permit(:demands_garage_id, :proposal, :doc1, :doc2, :doc3, :ttc_price, :expiration)
    end

    def new_quote_proposal_params
      params.permit(:demands_garage_id)
    end

    def set_price(params)
      return params unless params[:ttc_price]
      params[:ttc_price] = params[:ttc_price].gsub(',','.')
      params
    end
end
