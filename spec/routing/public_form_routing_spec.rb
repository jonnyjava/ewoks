describe PublicFormController do
  describe 'routing' do
    it { expect(get: '/public_form').to route_to('public_form#public_form') }
    it { expect(get: '/success').to route_to('public_form#success') }
    it { expect(post: '/public_form').to route_to('public_form#create') }
  end
end
