require 'spec_helper'

describe Holiday do
  it { should belong_to(:garage) }
  it { should validate_presence_of(:start_date) }
end
