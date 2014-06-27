require 'spec_helper'

describe Fee do
  it { should belong_to(:garage) }
  it { should validate_presence_of(:price) }
  it { should have_db_column(:price).with_options(precision: 2) }
end
