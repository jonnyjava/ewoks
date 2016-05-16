require 'spec_helper'

describe Quotables::DeliverController do
  login_admin
  describe "PUT #update" do
    context "with valid params" do
      let(:quote_proposal) { FactoryGirl.create(:quote_proposal) }
      let(:valid_attributes) { { deliverable_status: 'sent' } }

      it "redirects to the quote_proposal" do
        put :update, {id: quote_proposal.to_param, quote_proposal: valid_attributes}
        expect(response).to redirect_to(quote_proposals_path)
      end

      it "should update the deliverable status" do
        put :update, {id: quote_proposal.to_param, quote_proposal: valid_attributes}
        quote_proposal.reload
        expect(quote_proposal.status).to eq('sent')
      end
    end
  end
end
