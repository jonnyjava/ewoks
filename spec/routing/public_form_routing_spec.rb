require "spec_helper"

describe PublicFormController do
  describe "routing" do
    it { get("/public_form").should route_to("public_form#public_form") }
    it { get("/success").should route_to("public_form#success") }
    it { post("/public_form").should route_to("public_form#create") }
  end
end
