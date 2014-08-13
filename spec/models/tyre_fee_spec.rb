require 'spec_helper'

describe TyreFee do
  it { should belong_to(:garage) }
  it { should validate_presence_of(:name) }
  it { should validate_presence_of(:price) }
  it { should have_db_column(:price).with_options(precision: 4, scale: 2) }
end
