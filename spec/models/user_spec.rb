require 'spec_helper'

describe User do
  it { is_expected.to have_one(:garage).dependent(:destroy) }

  it "Should have Spain as default country" do
    user = User.new
    expect(user.country).to eq('Spain')
  end


end
