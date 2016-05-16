describe TimetablesController do
  login_admin

  describe 'PUT update' do
    let(:garage) { FactoryGirl.create(:garage) }
    let(:valid_attributes) { { "garage_id" => garage.id, "id" => garage.timetable.id, "timetable"=>{ "garage_id"=>garage.id } } }
    let(:noon_break_timetable) { { "sun_morning_open"=>"01:00", "sun_morning_close"=>"03:00", "sun_afternoon_open"=>"05:00", "sun_afternoon_close"=>"08:00" } }
    let(:daylong_timetable) { { "sun_morning_open"=>"02:00", "sun_afternoon_close"=>"22:00" } }

    context "with an empty timetable" do
      context "passing a noon break timetable" do
        it 'should set the 2 opening and closing times' do
          valid_attributes["timetable"].merge!(noon_break_timetable)
          put :update, valid_attributes
          garage.timetable.reload
          expect(garage.timetable.sun_morning_open).to_not be_nil
          expect(garage.timetable.sun_morning_close).to_not be_nil
          expect(garage.timetable.sun_afternoon_open).to_not be_nil
          expect(garage.timetable.sun_afternoon_close).to_not be_nil
        end
      end

      context "passing a daylong timetable" do
        it 'should not set the noon break time' do
          valid_attributes["timetable"].merge!(daylong_timetable)
          put :update, valid_attributes
          garage.timetable.reload
          expect(garage.timetable.sun_morning_open).to_not be_nil
          expect(garage.timetable.sun_morning_close).to be_nil
          expect(garage.timetable.sun_afternoon_open).to be_nil
          expect(garage.timetable.sun_afternoon_close).to_not be_nil
        end
      end
    end

    context "with a noon break timetable" do
      before(:each) do
        garage.timetable.update_attributes(noon_break_timetable)
        expect(garage.timetable.sun_morning_close).to_not be_nil
        expect(garage.timetable.sun_afternoon_open).to_not be_nil
      end

      context "passing a daylong timetable" do
        it "should unset the noon break time" do
          valid_attributes["timetable"].merge!(daylong_timetable)
          put :update, valid_attributes
          garage.timetable.reload
          expect(garage.timetable.sun_morning_close).to be_nil
          expect(garage.timetable.sun_afternoon_open).to be_nil
        end
      end

      context "passing a closing day flag" do
        it "should unset the 2 opening and closing times" do
          valid_attributes.merge!("sun_long"=>"1")
          put :update, valid_attributes
          garage.timetable.reload
          expect(garage.timetable.sun_morning_open).to be_nil
          expect(garage.timetable.sun_morning_close).to be_nil
          expect(garage.timetable.sun_afternoon_open).to be_nil
          expect(garage.timetable.sun_afternoon_close).to be_nil
        end
      end
    end
  end
end

