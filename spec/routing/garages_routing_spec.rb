require 'spec_helper'

describe GaragesController do
  describe 'routing' do
    it { expect(get: '/garages').to route_to('garages#index') }
    it { expect(get: '/garages/new').to route_to('garages#new') }
    it { expect(get: '/garages/1').to route_to('garages#show', id: '1') }
    it { expect(get: '/garages/1/edit').to route_to('garages#edit', id: '1') }
    it { expect(get: '/garages/signup_verification').to route_to('garages#signup_verification') }
    it { expect(post: '/garages').to route_to('garages#create') }
    it { expect(put: '/garages/1').to route_to('garages#update', id: '1') }
    it { expect(delete: '/garages/1').to route_to('garages#destroy', id: '1') }
    it { expect(delete: '/garages/1/destroy_logo').to route_to('garages#destroy_logo', id: '1') }
  end
end
