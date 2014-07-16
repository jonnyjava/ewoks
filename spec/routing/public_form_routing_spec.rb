require "spec_helper"

describe PublicFormController do
  describe "routing" do
    it "should route to #public_form" do
      get("/public_form").should route_to("public_form#public_form")
    end

    it "should route to #success" do
      get("/success").should route_to("public_form#success")
    end

    it "should route to #create" do
      post("/public_form").should route_to("public_form#create")
    end
  end
end
