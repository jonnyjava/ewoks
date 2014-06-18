require 'spec_helper'

describe Garage do
  it { should belong_to(:user) }
  it { should have_many(:holidays) }
  it { should have_many(:fees) }
  it { should have_and_belong_to_many(:properties) }
  it { should have_attached_file(:logo) }

  it { should validate_presence_of(:address) }
  it { should validate_presence_of(:zip) }
  it { should validate_presence_of(:city) }
  it { should validate_presence_of(:country) }
  it { should validate_presence_of(:phone) }
  it { should validate_presence_of(:tax_id) }
  it { should validate_attachment_content_type(:logo).allowing('image/png', 'image/jpg') }
end
