require 'spec_helper'

RSpec.describe ServiceCategoriesController, type: :routing do
  describe "routing" do
    it { expect(:get => "/service_categories").to route_to("service_categories#index") }
    it { expect(:get => "/service_categories/new").to_not route_to("service_categories#new") }
    it { expect(:get => "/service_categories/1").to_not route_to("service_categories#show", id: "1") }
    it { expect(:get => "/service_categories/1/edit").to_not route_to("service_categories#edit", id: "1") }
    it { expect(:post => "/service_categories").to_not route_to("service_categories#create") }
    it { expect(:put => "/service_categories/1").to_not route_to("service_categories#update", id: "1") }
    it { expect(:patch => "/service_categories/1").to_not route_to("service_categories#update", id: "1") }
    it { expect(:delete => "/service_categories/1").to_not route_to("service_categories#destroy", id: "1") }
  end
end
