require 'spec_helper'

describe Garages::ToggleStatusController do
  login_admin
  let(:garage) { FactoryGirl.create(:garage) }

  describe 'update' do
    it 'toggle the garage status' do
      put :update, { id: garage.id }
      garage.reload
      expect(garage.status).to eq('inactive')
      expect(response).to redirect_to(garages_url)
    end
  end
end
