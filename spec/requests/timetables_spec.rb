require 'spec_helper'

describe "Timetables" do
  login_user
  let!(:garage) { FactoryGirl.create(:garage) }
  let!(:timetable) { FactoryGirl.create(:timetable, garage: garage) }

  describe "edit" do
    it "should render the timetable" do
      get edit_garage_timetable_path(garage, timetable)
      response.status.should be(200)
    end
  end
end
