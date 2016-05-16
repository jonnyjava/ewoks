describe "Timetables" do
  login_admin
  let!(:garage) { FactoryGirl.create(:garage) }
  let!(:timetable) { FactoryGirl.create(:timetable, garage: garage) }

  describe "edit" do
    it "should render the timetable" do
      get edit_garage_timetable_path(garage, timetable)
      expect(response.status).to be(200)
    end
  end
end
