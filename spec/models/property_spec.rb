require 'spec_helper'

describe Property do
  it { should have_and_belong_to_many(:garages) }
end
