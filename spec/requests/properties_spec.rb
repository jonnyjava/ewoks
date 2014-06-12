require 'spec_helper'

describe "Properties" do
  describe "GET /properties" do
    login_user
    it "works! (now write some real specs)" do
      get properties_path
      response.status.should be(200)
    end
  end
end
