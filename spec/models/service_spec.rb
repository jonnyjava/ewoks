require 'spec_helper'

describe Service do
  it { is_expected.to belong_to(:service_category) }
  it { is_expected.to validate_presence_of(:name) }
end
