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

  describe 'find_by_radius_from_location' do
    let!(:garage_inside_radius) { FactoryGirl.create(:turin_garage) }
    let!(:garage_outside_radius) { FactoryGirl.create(:rome_garage) }

    context 'given a city' do
      it 'should return one garage' do
        garages = Garage.find_by_radius_from_location('Torino', 10)
        garages.first.should eq(garage_inside_radius)
        ids = garages.collect { |g| g[:id] }
        ids.count.should be(1)
      end
    end

    context 'given a zip code' do
      it 'should return one garage' do
        garages = Garage.find_by_radius_from_location('10135, Italy', 10)
        garages.first.should eq(garage_inside_radius)
        ids = garages.collect { |g| g[:id] }
        ids.count.should be(1)
      end
    end

    context 'given a city and a zip code' do
      it 'should return one garage' do
        garages = Garage.find_by_radius_from_location('Torino, 10135, Italy', 10)
        garages.first.should eq(garage_inside_radius)
        ids = garages.collect { |g| g[:id] }
        ids.count.should be(1)
      end
    end

    context 'without radius' do
      it 'should return one garage' do
        garages = Garage.find_by_radius_from_location('Torino, 10141, Italy')
        garages.first.should eq(garage_inside_radius)
        ids = garages.collect { |g| g[:id] }
        ids.count.should be(1)
      end
    end
  end
end



