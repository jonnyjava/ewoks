require 'spec_helper'

describe GarageProperty do
  it { should belong_to(:garage) }
  it { should belong_to(:property) }
end
