require "spec_helper"

describe QuoteProposalsController do
  context "with an admin" do
    let(:quote_proposal) { FactoryGirl.create(:quote_proposal) }
    login_admin
    describe "GET #index" do
      it "assigns all quote_proposals as @quote_proposals" do
        get :index, {}
        expect(assigns(:quote_proposals)).to eq([quote_proposal])
      end
    end

    describe "GET #show" do
      it "assigns the requested quote_proposal as @quote_proposal" do
        get :show, {id: quote_proposal.to_param}
        expect(assigns(:quote_proposal)).to eq(quote_proposal)
      end
    end

    describe "GET #new" do
      it "assigns a new quote_proposal as @quote_proposal" do
        demand_garage = FactoryGirl.create(:demands_garage)
        get :new, {demands_garage_id: demand_garage.id}
        expect(assigns(:quote_proposal)).to be_a_new(QuoteProposal)
      end
    end

    describe "GET #edit" do
      it "assigns the requested quote_proposal as @quote_proposal" do
        get :edit, {id: quote_proposal.to_param}
        expect(assigns(:quote_proposal)).to eq(quote_proposal)
      end
    end

    describe "PUT #update" do
      context "with valid params" do
        it "redirects to the quote_proposal" do
          valid_attributes = FactoryGirl.attributes_for(:quote_proposal)
          put :update, {id: quote_proposal.to_param, quote_proposal: valid_attributes}
          expect(response).to redirect_to(quote_proposal)
        end
      end

      context "with invalid params" do

        it "re-renders the 'edit' template" do
          put :update, {id: quote_proposal.to_param, quote_proposal: {"ttc_price"=>nil}}
          expect(response).to render_template("edit")
        end
      end
    end

    describe "DELETE #destroy" do
      it "destroys the requested quote_proposal" do
        quote_proposal
        expect {
          delete :destroy, {id: quote_proposal.to_param}
        }.to change(QuoteProposal, :count).by(-1)
      end

      it "redirects to the quote_proposals list" do
        delete :destroy, {id: quote_proposal.to_param}
        expect(response).to redirect_to(quote_proposals_url)
      end
    end
  end

  context "with an owner" do
    login_owner
    let(:garage) { FactoryGirl.create(:garage, user: subject.current_user) }
    let(:demands_garage) { FactoryGirl.create(:demands_garage, garage: garage) }
    let(:valid_attributes) { FactoryGirl.attributes_for(:quote_proposal, demands_garage_id: demands_garage.id) }

    describe "POST #create" do
      context "with valid params" do
        it "creates a new QuoteProposal" do
          expect {
            post :create, {quote_proposal: valid_attributes}
          }.to change(QuoteProposal, :count).by(1)
        end

        it "redirects to the created quote_proposal" do
          post :create, {quote_proposal: valid_attributes}
          expect(response).to redirect_to(QuoteProposal.last)
        end
      end

      context "with invalid params" do
        let(:invalid_attributes) { {demands_garage_id: demands_garage.id, quote_proposal: {"ttc_price"=>nil}} }
        it "should not create a new QuoteProposal" do
          quotes = QuoteProposal.count
          post :create, {:quote_proposal => invalid_attributes}
          expect(QuoteProposal.count).to eq(quotes)
        end

        it "re-renders the 'new' template" do
          post :create, {quote_proposal: invalid_attributes}
          expect(response).to render_template("new")
        end
      end
    end
  end
end
