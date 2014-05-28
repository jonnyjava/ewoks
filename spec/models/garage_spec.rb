require 'spec_helper'

describe Garage do
  it { should have_many(:holidays) }
  it { should have_many(:fees) }
end
