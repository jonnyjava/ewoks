require 'spec_helper'

describe GarageRecruitable do
  it { is_expected.to validate_uniqueness_of(:tax_id) }
  it { is_expected.to validate_presence_of(:name) }
  it { is_expected.to validate_presence_of(:tax_id) }
end
