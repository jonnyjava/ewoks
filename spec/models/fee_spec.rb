require 'spec_helper'

describe Fee do
  it { should belong_to(:garage) }
  it { should validate_presence_of(:price) }
end
