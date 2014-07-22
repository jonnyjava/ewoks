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
  it { should validate_uniqueness_of(:email) }

  describe 'find_by_radius_from_location' do
    let!(:garage_inside_radius) { FactoryGirl.create(:turin_garage) }
    let!(:garage_outside_radius) { FactoryGirl.create(:rome_garage) }
    let(:outside_coords) { { latitude: 41.8084, longitude: 12.3015 } }
    before(:each) do
      garage_outside_radius.update_attributes(outside_coords)
    end

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

  describe 'get countries' do
    let!(:admin) { FactoryGirl.create(:admin) }
    let!(:country_manager) { FactoryGirl.create(:country_manager) }

    context 'user is admin' do
      it 'should return all countries' do
        Garage.countries(admin).should eq(Garage::COUNTRIES)
      end

      it "should return only the country's country manager" do
        Garage.countries(country_manager).should eq([country_manager.country])
      end
    end
  end
end
