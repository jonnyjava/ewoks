require 'spec_helper'

describe ServiceCategory do
  it { is_expected.to have_many(:services).dependent(:destroy) }
  it { is_expected.to validate_presence_of(:name) }
end
