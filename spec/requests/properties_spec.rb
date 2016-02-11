require 'spec_helper'

describe "Properties" do
  describe "GET /properties" do
    login_user
    it "works! (now write some real specs)" do
      get properties_path
      expect(response.status).to be(200)
    end
  end
end
