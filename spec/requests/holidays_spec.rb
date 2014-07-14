require 'spec_helper'

describe "Holidays" do
  login_user
  let!(:garage) { FactoryGirl.create(:garage_with_timetable) }
  let!(:holiday) { FactoryGirl.create(:holiday, garage: garage) }
  describe "index" do
    it "should render the holiday index" do
      get garage_holidays_path(garage)
      response.status.should be(200)
    end
  end

  describe "get" do
    it "should render the holiday sheet" do
      get garage_holiday_path(garage, holiday)
      response.status.should be(200)
    end
  end

  describe "edit" do
    it "should render the holiday sheet" do
      get edit_garage_holiday_path(garage, holiday)
      response.status.should be(200)
    end
  end
end
