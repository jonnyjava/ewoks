require 'spec_helper'

describe ServicesController do
  describe 'routing' do
    it { expect(get: '/services').to route_to('services#index') }
    it { expect(get: '/services/1/edit').to route_to('services#edit', id: '1') }
    it { expect(put: '/services/1').to route_to('services#update', id: '1') }
    it { expect(patch: '/services/1').to route_to('services#update', id: '1') }

    it { expect(get: '/services/new').to_not route_to('services#new') }
    it { expect(get: '/services/1').to_not route_to('services#show', id: '1') }
    it { expect(post: '/services').to_not route_to('services#create') }
    it { expect(delete: '/services/1').to_not route_to('services#destroy', id: '1') }
  end
end
