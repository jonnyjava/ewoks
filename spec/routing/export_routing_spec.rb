require "spec_helper"

RSpec.describe Recruitables::ExportController, type: :routing do
  describe "routing" do
    it { expect(get: "/recruitables/export").to route_to("recruitables/export#index") }
  end
end
