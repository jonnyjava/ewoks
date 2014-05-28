require 'spec_helper'

describe Garage do
  it { should have_many(:holidays) }
  it { should have_many(:fees) }
  it { should have_and_belong_to_many(:properties) }
end
