require "spec_helper"

RSpec.describe GarageRecruitablesController, type: :routing do
  describe "routing" do

    it "routes to #index" do
      expect(:get => "/garage_recruitables").to route_to("garage_recruitables#index")
    end

    it "routes to #new" do
      expect(:get => "/garage_recruitables/new").to route_to("garage_recruitables#new")
    end

    it "routes to #show" do
      expect(:get => "/garage_recruitables/1").to route_to("garage_recruitables#show", id: "1")
    end

    it "routes to #edit" do
      expect(:get => "/garage_recruitables/1/edit").to route_to("garage_recruitables#edit", id: "1")
    end

    it "routes to #create" do
      expect(:post => "/garage_recruitables").to route_to("garage_recruitables#create")
    end

    it "routes to #update via PUT" do
      expect(:put => "/garage_recruitables/1").to route_to("garage_recruitables#update", id: "1")
    end

    it "routes to #update via PATCH" do
      expect(:patch => "/garage_recruitables/1").to route_to("garage_recruitables#update", id: "1")
    end

    it "routes to #destroy" do
      expect(:delete => "/garage_recruitables/1").to route_to("garage_recruitables#destroy", id: "1")
    end

  end
end
