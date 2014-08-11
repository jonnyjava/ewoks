require 'spec_helper'

describe PublicWizardController do
  describe 'routing' do
    it { get('/public_wizard').should route_to('public_wizard#public_wizard') }
    it { post('/public_wizard_create_garage').should route_to('public_wizard#create_garage') }
  end
end
