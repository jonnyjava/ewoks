require 'spec_helper'

describe ErrorsController do
  describe 'routing to unknown' do
    it 'should route to error_404' do
      get('/alderaan').should route_to('errors#error_404', path: 'alderaan')
    end
  end

  describe 'custom error handling' do
    it 'should route to error_404' do
      get('/404').should route_to('errors#error_404')
    end
    it 'should route to error_422' do
      get('/422').should route_to('errors#error_422')
    end
    it 'should route to error_500' do
      get('/500').should route_to('errors#error_500')
    end
  end
end
