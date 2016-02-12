require 'spec_helper'

describe GarageProperty do
  it { is_expected.to belong_to(:garage) }
  it { is_expected.to belong_to(:property) }
end
