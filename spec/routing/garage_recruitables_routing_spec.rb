require "spec_helper"

RSpec.describe GarageRecruitablesController, type: :routing do
  describe "routing" do

    it "should route to #index" do
      expect(get: "/garage_recruitables").to route_to("garage_recruitables#index")
    end

    it "should route to #new" do
      expect(get: "/garage_recruitables/new").to_not route_to("garage_recruitables#new")
    end

    it "should route to #show" do
      expect(get: "/garage_recruitables/1").to route_to("garage_recruitables#show", id: "1")
    end

    it "should route to #edit" do
      expect(get: "/garage_recruitables/1/edit").to route_to("garage_recruitables#edit", id: "1")
    end

    it "should route to #export" do
      expect(get: "/garage_recruitables/export").to route_to("garage_recruitables#export")
    end

    it "should route to #create" do
      expect(post: "/garage_recruitables").to route_to("garage_recruitables#create")
    end

    it "should route to #update via PUT" do
      expect(put: "/garage_recruitables/1").to route_to("garage_recruitables#update", id: "1")
    end

    it "should route to #update via PATCH" do
      expect(patch: "/garage_recruitables/1").to route_to("garage_recruitables#update", id: "1")
    end

    it "should route to #destroy" do
      expect(delete: "/garage_recruitables/1").to route_to("garage_recruitables#destroy", id: "1")
    end
  end
end
