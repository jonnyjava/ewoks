require 'spec_helper'

describe PublicFormControllerController do

  describe "GET 'public_form'" do
    it "returns http success" do
      get 'public_form'
      response.should be_success
    end
  end

end
