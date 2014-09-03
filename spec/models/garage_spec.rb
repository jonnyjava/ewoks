require 'spec_helper'

describe Garage do
  it { should belong_to(:user) }
  it { should have_many(:holidays) }
  it { should have_many(:tyre_fees) }
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

  describe 'callbacks' do
    let(:garage) { FactoryGirl.create(:garage) }
    it { Garage.any_instance.should_receive(:send_signup_confirmation).with(garage.email) }
  end

  describe 'signup_verification_token' do
    it 'should generate an unique token' do
      garage1 = FactoryGirl.create(:garage, status: Garage::TO_BE_CONFIRMED)
      garage2 = FactoryGirl.create(:garage, status: Garage::TO_BE_CONFIRMED)
      token1 = garage1.signup_verification_token
      token2 = garage2.signup_verification_token
      token1.should_not eq(token2)
    end
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
      garage.inactive!
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

  describe 'by_price_in_a_range' do
    let!(:spanish_garage) { FactoryGirl.create(:spanish_garage) }
    let!(:french_garage) { FactoryGirl.create(:french_garage) }
    let!(:spanish_fee) { FactoryGirl.create(:spanish_fee, garage: spanish_garage) }
    let!(:french_fee) { FactoryGirl.create(:french_fee, garage: french_garage) }

    it 'should return the spanish garage passing min = 10 and max 30' do
      garages = Garage.by_price_in_a_range(10,30)
      ids = garages.map { |g| g[:id] }
      ids.count.should be(1)
      ids.should include(spanish_garage.id)
      ids.should_not include(french_garage.id)
    end

    it 'should return the spanish garage passing min = 10' do
      garages = Garage.by_price_in_a_range(20, nil)
      ids = garages.map { |g| g[:id] }
      ids.count.should be(1)
      ids.should include(spanish_garage.id)
      ids.should_not include(french_garage.id)
    end

    it 'should return the spanish garage passing max 30' do
      garages = Garage.by_price_in_a_range(nil, 30)
      ids = garages.map { |g| g[:id] }
      ids.count.should be(1)
      ids.should include(spanish_garage.id)
      ids.should_not include(french_garage.id)
    end

    it 'should return no garages passing nothing' do
      garages = Garage.by_price_in_a_range(nil, nil)
      ids = garages.map { |g| g[:id] }
      ids.count.should be(0)
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

  describe 'scopes' do
    let!(:garage_without_fee) { FactoryGirl.create(:garage) }
    let!(:garage) { FactoryGirl.create(:turin_garage) }  
    let!(:garage_rome) { FactoryGirl.create(:rome_garage) }
    let!(:garage_spanish) { FactoryGirl.create(:spanish_garage) }
    let!(:garage_french) { FactoryGirl.create(:french_garage) }

    before (:each) do
      FactoryGirl.create(:tyre_fee, garage: garage)
      FactoryGirl.create(:tyre_fee, garage: garage_rome)
      FactoryGirl.create(:tyre_fee, garage: garage_spanish)
      FactoryGirl.create(:tyre_fee, garage: garage_french)
    end

    after (:each) do
      @result.first.should eq(garage)
    end

    it 'should filter garages by country' do
      @result = Garage.by_country('Italy')
      @result.count.should be(2)
      garages_countries = @result.map(&:country).uniq 
      garages_countries.should == ['Italy']
      garages_countries.count.should be(1)
    end

    it 'should filter garages by city' do
      @result = Garage.by_city('Torino')
      @result.count.should be(1)
      @result.first.city.should be_eql('Torino')
    end

    it 'should filter garages by zip' do
      @result = Garage.by_zip('10141')
      @result.count.should be(1)
      @result.first.zip.should be_eql('10141')
    end

    it 'should return only garages with tyre fees' do
      @result = Garage.by_tyre_fee
      @result.count.should be(4)
      @result.each { |garage| garage.tyre_fees.should_not be_empty }
    end

    context 'by default' do
      it 'should filter by zip' do
        @result = Garage.by_default('10141', nil, nil)
        @result.count.should be(1)
        @result.first.zip.should be_eql('10141')
      end

      it 'should filter by country' do
        @result = Garage.by_default(nil, nil, 'Italy')
        @result.count.should be(2)
        garages_countries = @result.map(&:country).uniq 
        garages_countries.should == ['Italy']
        garages_countries.count.should be(1)
      end

      it 'should filter by city' do
        @result = Garage.by_default(nil, 'Torino', nil)
        @result.count.should be(1)
        @result.first.city.should be_eql('Torino')
      end

      it 'should filter by tyre fee' do
        @result = Garage.by_default(nil, nil, nil)
        @result.count.should be(4)
        @result.each { |garage| garage.tyre_fees.should_not be_empty }
      end
    end
  end
end