require 'spec_helper'

describe WizardController do
  describe 'routing' do
    it { expect(get('/wizard')).to route_to('wizard#wizard') }
    it { expect(post('/wizard_create_garage')).to route_to('wizard#create_garage') }

    it { expect(get('/wizard_timetable/1')).to route_to('wizard#timetable', garage_id: '1') }
    it { expect(patch('/wizard_update_timetable/1')).to route_to('wizard#update_timetable', garage_id: '1') }

    it { expect(get('/wizard_holiday/1')).to route_to('wizard#holiday', garage_id: '1') }
    it { expect(post('/wizard_create_holiday/1')).to route_to('wizard#create_holiday', garage_id: '1') }

    it { expect(get('/wizard_fee/1')).to route_to('wizard#fee', garage_id: '1') }
    it { expect(post('/wizard_create_fee/1')).to route_to('wizard#create_fee', garage_id: '1') }
  end
end
