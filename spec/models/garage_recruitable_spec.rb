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
  end
end
