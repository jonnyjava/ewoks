require 'spec_helper'

describe GarageRecruitable do
  it { is_expected.to validate_uniqueness_of(:tax_id) }
  it { is_expected.to validate_presence_of(:name) }
  it { is_expected.to validate_presence_of(:email) }
  it { is_expected.to validate_presence_of(:tax_id) }

  describe "scopes" do
    let(:recruitable) { FactoryGirl.create(:garage_recruitable) }
    attributes = %w(name zip city email)
    attributes.each do |attribute|
      it "should filter by #{attribute}" do
        attribute_value = recruitable.send(attribute)
        @filtered_garages = GarageRecruitable.filter_by(attribute, attribute_value[rand(attribute_value.size)])
        expect(@filtered_garages.count).to be(1)
        expect(@filtered_garages.first.send(attribute)).to be_eql(attribute_value)
      end
    end

    it 'should ignore non string attributes in filter_by scope' do
      FactoryGirl.create(:garage_recruitable)
      @filtered_garages = GarageRecruitable.filter_by('status', recruitable.status)
      expect(@filtered_garages.count).to be(GarageRecruitable.count)
    end

    it 'should filter by status' do
      status = recruitable.status
      @filtered_garages = GarageRecruitable.by_status(status)
      expect(@filtered_garages.count).to be(1)
      expect(@filtered_garages.first.status).to be_eql(status)
    end
  end

  describe 'recruiting_token' do
    it 'should generate an unique token' do
      recruitable1 = FactoryGirl.create(:garage_recruitable)
      recruitable2 = FactoryGirl.create(:garage_recruitable)
      expect(recruitable1.token).not_to eq(recruitable2.token)
    end
  end

  describe 'find_by_token' do
    it 'should return only one garage_recruitable' do
      recruitable1 = FactoryGirl.create(:garage_recruitable)
      recruitable2 = FactoryGirl.create(:garage_recruitable)
      result = GarageRecruitable.find_by_token(recruitable1.token)
      expect(result).to eq(recruitable1)
      expect(result).not_to eq(recruitable2)
    end
  end

  describe 'fill_empty_token' do
    it 'should assign a token to all GarageRecruitables without it' do
      rand(10).times { FactoryGirl.create(:garage_recruitable) }
      GarageRecruitable.update_all(token: nil)
      GarageRecruitable.fill_empty_token
      expect(GarageRecruitable.where.not(token: nil).size).to eq(GarageRecruitable.count)
      expect(GarageRecruitable.where(token: nil).size).to eq(0)
    end
  end
end
