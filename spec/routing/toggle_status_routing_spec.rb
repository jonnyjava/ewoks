describe Garages::ToggleStatusController do
  describe 'routing' do
    it { expect(put: '/garages/toggle_status/1').to route_to('garages/toggle_status#update', id: '1') }
    it { expect(patch: '/garages/toggle_status/1').to route_to('garages/toggle_status#update', id: '1') }
  end
  it 'routes correctly' do
    assert_generates 'garages/toggle_status/1', { controller: 'garages/toggle_status', action: 'update', id: '1' }
  end
end
