require 'spec_helper'

describe API::V1::GarageRegistrationsController do
  describe 'routing' do
    it { expect(post('/api/v1/garage_registrations')).to route_to('api/v1/garage_registrations#create') }
    it { expect(patch('/api/v1/garage_registrations/1')).to route_to('api/v1/garage_registrations#update', id: '1') }
  end

  describe 'versioning' do
    it 'routes version' do
      assert_generates 'api/v1/garage_registrations', { controller: 'api/v1/garage_registrations', action: 'create' }
    end
  end
end
