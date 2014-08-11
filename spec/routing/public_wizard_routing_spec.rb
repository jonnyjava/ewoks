require 'spec_helper'

describe PublicWizardController do
  describe 'routing' do
    it { get('/public_wizard').should route_to('public_wizard#public_wizard') }
    it { post('/public_wizard_create_garage').should route_to('public_wizard#create_garage') }

    it { get('/public_wizard_show_timetable/1').should route_to('public_wizard#show_timetable', garage_id: '1') }
    it { post('/public_wizard_create_timetable/1').should route_to('public_wizard#create_timetable', garage_id: '1') }

    it { get('/public_wizard_show_holiday/1').should route_to('public_wizard#show_holiday', garage_id: '1') }
    it { post('/public_wizard_create_holiday/1').should route_to('public_wizard#create_holiday', garage_id: '1') }
  end
end
