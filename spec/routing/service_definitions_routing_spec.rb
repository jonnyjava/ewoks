require 'spec_helper'

describe ServiceDefinitionsController do
  describe 'routing' do
    it { expect(get: '/service_definitions').to route_to('service_definitions#index') }
    it { expect(get: '/service_definitions/new').to route_to('service_definitions#new') }
    it { expect(get: '/service_definitions/1').not_to route_to('service_definitions#show', id: '1') }
    it { expect(get: '/service_definitions/1/edit').not_to route_to('service_definitions#edit', id: '1') }
    it { expect(post: '/service_definitions').to route_to('service_definitions#create') }
    it { expect(put: '/service_definitions/1').to route_to('service_definitions#update', id: '1') }
    it { expect(patch: '/service_definitions/1').to route_to('service_definitions#update', id: '1') }
    it { expect(delete: '/service_definitions/1').to route_to('service_definitions#destroy', id: '1') }
  end
end
