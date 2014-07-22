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

  describe 'callbacks' do
    let(:garage) { FactoryGirl.create(:garage) }

    it { Garage.any_instance.should_receive(:send_signup_confirmation).with(garage.email) }
  end

  describe 'find_by_token' do
    it 'should return only one garage' do
      garage1 = FactoryGirl.create(:garage, status: Garage::TO_BE_CONFIRMED)
      garage2 = FactoryGirl.create(:garage, status: Garage::TO_BE_CONFIRMED)
      token = garage1.signup_verification_token
      result = Garage.find_by_signup_verification_token(token)
      result.should eq(garage1)
      result.should_not eq(garage2)
    end
  end
  describe 'disable!' do
    it 'should make the garage inactive' do
      garage = FactoryGirl.create(:garage)
      garage.disable!
      garage.status.should be(Garage::INACTIVE)
    end
  end

  describe 'create_my_owner' do
    it 'should create a new owner who owns the garage' do
      garage = FactoryGirl.create(:garage)
      garage.create_my_owner
      User.find(garage.owner_id).should_not be_nil
    end
  end

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
end
