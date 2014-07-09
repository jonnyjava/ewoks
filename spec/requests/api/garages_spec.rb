require 'spec_helper'

describe "Garages" do

  describe "index" do
    it "should return status 200" do
      get 'http://api.localhost.dev/garages'
      response.status.should be(200)
      response.body.should_not be_empty
    end
  end
end
