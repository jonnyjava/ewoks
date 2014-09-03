require 'spec_helper'

describe "users/show" do
  it "renders user show" do
    @user = FactoryGirl.create(:owner)
    render
  end
end
