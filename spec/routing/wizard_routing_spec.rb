require 'spec_helper'

describe WizardController do
  describe 'routing' do
    it { get('/wizard').should route_to('wizard#wizard') }
    it { post('/wizard_create_garage').should route_to('wizard#create_garage') }

    it { get('/wizard_timetable/1').should route_to('wizard#timetable', garage_id: '1') }
    it { post('/wizard_create_timetable/1').should route_to('wizard#create_timetable', garage_id: '1') }

    it { get('/wizard_holiday/1').should route_to('wizard#holiday', garage_id: '1') }
    it { post('/wizard_create_holiday/1').should route_to('wizard#create_holiday', garage_id: '1') }

    it { get('/wizard_fee/1').should route_to('wizard#fee', garage_id: '1') }
    it { post('/wizard_create_fee/1').should route_to('wizard#create_fee', garage_id: '1') }
  end
end
