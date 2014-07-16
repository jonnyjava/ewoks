require 'spec_helper'

describe PublicFormController do

  describe "GET 'public_form'" do
    it "returns http success" do
      get 'public_form'
      response.should be_success
    end
  end

end
