require 'spec_helper'

describe Property do
  it { is_expected.to have_many(:garages).through(:garage_properties) }
end
