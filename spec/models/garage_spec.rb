require 'spec_helper'

describe Garage do
  it { should belong_to(:user) }
  it { should have_many(:holidays) }
  it { should have_many(:fees) }
  it { should have_one(:timetable) }
  it { should have_and_belong_to_many(:properties) }
  it { should have_attached_file(:logo) }

  it { should validate_presence_of(:street) }
  it { should validate_presence_of(:zip) }
  it { should validate_presence_of(:city) }
  it { should validate_presence_of(:country) }
  it { should validate_presence_of(:phone) }
  it { should validate_presence_of(:tax_id) }
  it { should validate_attachment_content_type(:logo).allowing('image/png', 'image/jpg') }

  describe 'find_by_radius_from_somewhere' do
    let!(:garage_inside_radius) { FactoryGirl.create(:garage, zip: '10141', city: 'Torino', country: 'Italy', street: 'Via Monginevro 162') }
    let!(:garage_outside_radius) { FactoryGirl.create(:garage, zip: '00054', city: 'Roma', country: 'Italy', street: 'Via G. Ferraris 2/4') }

    context 'given a city' do
      it 'should return one garage' do
        garages = Garage.find_by_radius_from_somewhere('Torino', 10)
        garages.first.should eq(garage_inside_radius)
        ids = garages.collect { |g| g[:id] }
        ids.count.should be(1)
      end
    end

    context 'given a city and a zip code' do
      it 'should return one garage' do
        garages = Garage.find_by_radius_from_somewhere('10135, Italy', 10)
        garages.first.should eq(garage_inside_radius)
        ids = garages.collect { |g| g[:id] }
        ids.count.should be(1)
      end
    end
  end
end



