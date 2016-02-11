require 'spec_helper'

describe GaragesController do
  describe 'routing' do

    it 'routes to #index' do
      expect(get('/garages')).to route_to('garages#index')
    end

    it 'routes to #new' do
      expect(get('/garages/new')).to route_to('garages#new')
    end

    it 'routes to #show' do
      expect(get('/garages/1')).to route_to('garages#show', id: '1')
    end

    it 'routes to #edit' do
      expect(get('/garages/1/edit')).to route_to('garages#edit', id: '1')
    end

    it { expect(get('/garages/signup_verification/1')).to route_to('garages#signup_verification', token: '1') }

    it 'routes to #create' do
      expect(post('/garages')).to route_to('garages#create')
    end

    it 'routes to #update' do
      expect(put('/garages/1')).to route_to('garages#update', id: '1')
    end

    it 'routes to #destroy' do
      expect(delete('/garages/1')).to route_to('garages#destroy', id: '1')
    end

    it 'routes to #destroy_logo' do
      expect(delete('/garages/1/destroy_logo')).to route_to('garages#destroy_logo', id: '1')
    end
  end
end
