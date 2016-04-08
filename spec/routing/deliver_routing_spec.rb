require "spec_helper"

RSpec.describe Quotables::DeliverController, type: :routing do
  describe "routing" do
    it { expect(put: "/quotables/deliver/25").to route_to("quotables/deliver#update", id: "25") }
    it { expect(patch: "/quotables/deliver/25").to route_to("quotables/deliver#update", id: "25") }
  end
end
