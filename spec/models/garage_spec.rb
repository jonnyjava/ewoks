require 'spec_helper'

describe Garage do
  it { is_expected.to belong_to(:user) }
  it { is_expected.to have_many(:holidays).dependent(:destroy) }
  it { is_expected.to have_many(:tyre_fees).dependent(:destroy) }
  it { is_expected.to have_one(:timetable).dependent(:destroy) }
  it { is_expected.to have_attached_file(:logo) }

  it { is_expected.to validate_presence_of(:street) }
  it { is_expected.to validate_presence_of(:zip) }
  it { is_expected.to validate_presence_of(:country) }
  it { is_expected.to validate_presence_of(:phone) }
  it { is_expected.to validate_presence_of(:tax_id) }
  it { is_expected.to validate_attachment_content_type(:logo).allowing('image/png', 'image/jpeg') }
  it { is_expected.to validate_uniqueness_of(:email) }

  describe 'callbacks' do
    after(:each) do
      FactoryGirl.create(:garage)
    end
    it { expect_any_instance_of(Garage).to receive(:send_signup_confirmation) }
    it { expect_any_instance_of(Garage).to receive(:create_my_timetable) }
  end

  describe 'signup_verification_token' do
    it 'should generate an unique token' do
      garage1 = FactoryGirl.create(:garage, status: Garage::TO_BE_CONFIRMED)
      garage2 = FactoryGirl.create(:garage, status: Garage::TO_BE_CONFIRMED)
      token1 = garage1.signup_verification_token
      token2 = garage2.signup_verification_token
      expect(token1).not_to eq(token2)
    end
  end

  describe 'find_by_token' do
    it 'should return only one garage' do
      garage1 = FactoryGirl.create(:garage, status: Garage::TO_BE_CONFIRMED)
      garage2 = FactoryGirl.create(:garage, status: Garage::TO_BE_CONFIRMED)
      token = garage1.signup_verification_token
      result = Garage.find_by_signup_verification_token(token)
      expect(result).to eq(garage1)
      expect(result).not_to eq(garage2)
    end
  end

  describe 'disable!' do
    it 'should make the garage inactive' do
      garage = FactoryGirl.create(:garage)
      garage.inactive!
      expect(garage.status).to be(Garage::INACTIVE)
    end
  end

  describe 'create_my_owner' do
    it 'should create a new owner who owns the garage' do
      garage = FactoryGirl.create(:garage)
      garage.create_my_owner
      expect(User.find(garage.owner_id)).not_to be_nil
    end
  end

  describe 'create_my_timetable' do
    it 'should create a new owner who owns the garage' do
      garage = FactoryGirl.create(:garage)
      garage.create_my_timetable
      expect(garage.timetable).not_to be_nil
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
      expect(ids.count).to be(1)
      expect(ids).to include(spanish_garage.id)
      expect(ids).not_to include(french_garage.id)
    end

    it 'should return the spanish garage passing min = 10' do
      garages = Garage.by_price_in_a_range(20, nil)
      ids = garages.map { |g| g[:id] }
      expect(ids.count).to be(1)
      expect(ids).to include(spanish_garage.id)
      expect(ids).not_to include(french_garage.id)
    end

    it 'should return the spanish garage passing max 30' do
      garages = Garage.by_price_in_a_range(nil, 30)
      ids = garages.map { |g| g[:id] }
      expect(ids.count).to be(1)
      expect(ids).to include(spanish_garage.id)
      expect(ids).not_to include(french_garage.id)
    end

    it 'should return no garages passing nothing' do
      garages = Garage.by_price_in_a_range(nil, nil)
      ids = garages.map { |g| g[:id] }
      expect(ids.count).to be(0)
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
        expect(garages.first).to eq(garage_inside_radius)
        ids = garages.collect { |g| g[:id] }
        expect(ids.count).to be(1)
      end
    end

    context 'given a zip code' do
      it 'should return one garage' do
        garages = Garage.find_by_radius_from_location('10135, Italy', 10)
        expect(garages.first).to eq(garage_inside_radius)
        ids = garages.collect { |g| g[:id] }
        expect(ids.count).to be(1)
      end
    end

    context 'given a city and a zip code' do
      it 'should return one garage' do
        garages = Garage.find_by_radius_from_location('Torino, 10135, Italy', 10)
        expect(garages.first).to eq(garage_inside_radius)
        ids = garages.collect { |g| g[:id] }
        expect(ids.count).to be(1)
      end
    end

    context 'without radius' do
      it 'should return one garage' do
        garages = Garage.find_by_radius_from_location('Torino, 10141, Italy')
        expect(garages.first).to eq(garage_inside_radius)
        ids = garages.collect { |g| g[:id] }
        expect(ids.count).to be(1)
      end
    end
  end

  describe 'get countries' do
    let!(:admin) { FactoryGirl.create(:admin) }
    let!(:country_manager) { FactoryGirl.create(:country_manager) }

    context 'user is admin' do
      it 'should return all countries' do
        expect(Garage.countries(admin)).to eq(COUNTRIES)
      end

      it "should return only the country's country manager" do
        expect(Garage.countries(country_manager)).to eq([country_manager.country])
      end
    end
  end

  describe 'scopes' do
    let!(:garage_without_fee) { FactoryGirl.create(:garage, country: "Belgium") }
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
      expect(@result.first).to eq(garage)
    end

    it 'should filter garages by country' do
      @result = Garage.by_country('Italy')
      expect(@result.count).to be(2)
      garages_countries = @result.map(&:country).uniq
      expect(garages_countries).to eq(['Italy'])
      expect(garages_countries.count).to be(1)
    end

    it 'should filter garages by city' do
      @result = Garage.by_city('Torino')
      expect(@result.count).to be(1)
      expect(@result.first.city).to be_eql('Torino')
    end

    it 'should filter garages by zip' do
      @result = Garage.by_zip('10141')
      expect(@result.count).to be(1)
      expect(@result.first.zip).to be_eql('10141')
    end

    it 'should return only garages with tyre fees' do
      @result = Garage.by_tyre_fee
      expect(@result.count).to be(4)
      @result.each { |garage| expect(garage.tyre_fees).not_to be_empty }
    end

    context 'by default' do
      it 'should filter by zip' do
        @result = Garage.by_default('10141', nil)
        expect(@result.count).to be(1)
        expect(@result.first.zip).to be_eql('10141')
      end

      it 'should filter by city' do
        @result = Garage.by_default(nil, 'Torino')
        expect(@result.count).to be(1)
        expect(@result.first.city).to be_eql('Torino')
      end

      it 'should filter by tyre fee' do
        @result = Garage.by_default(nil, nil)
        expect(@result.count).to be(4)
        @result.each { |garage| expect(garage.tyre_fees).not_to be_empty }
      end
    end
  end


  describe 'filter by date' do
    let!(:garage_without_holidays) { FactoryGirl.create(:garage) }
    let(:garage_with_holidays) { FactoryGirl.create(:garage) }
    let!(:holiday) { FactoryGirl.create(:holiday, garage: garage_with_holidays) }

    it 'should return garages with holidays and available' do
      date = '2014-12-20'
      result = Garage.by_date(date)
      expect(result.count).to be(1)
      expect(result.first.id).to eq(garage_with_holidays.id)
    end

    it 'should return garages without holidays' do
      result = Garage.garages_without_holidays
      expect(result.count).to be(1)
      expect(result.first.id).to eq(garage_without_holidays.id)
    end

    describe "opened_at" do
      it 'should return only garages availables at given date' do
        another_garage = FactoryGirl.create(:garage)
        another_holiday = FactoryGirl.create(:holiday, start_date: '2014-08-15', end_date: '2014-08-31', garage: another_garage)
        date = '2014-08-25'
        result = Garage.opened_at(date)

        expect(result.count).to be(2)
        expect(result.map(&:id)).not_to include(another_garage.id)
      end
    end
  end
end
