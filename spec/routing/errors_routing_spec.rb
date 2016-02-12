require 'spec_helper'

describe ErrorsController do
  describe 'routing to unknown' do
    it 'should route to error_404' do
      expect(get('/alderaan')).to route_to('errors#error_404', path: 'alderaan')
    end
  end

  describe 'custom error handling' do
    it 'should route to error_404' do
      expect(get('/404')).to route_to('errors#error_404')
    end
    it 'should route to error_422' do
      expect(get('/422')).to route_to('errors#error_422')
    end
    it 'should route to error_500' do
      expect(get('/500')).to route_to('errors#error_500')
    end
  end
end
