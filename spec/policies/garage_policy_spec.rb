require 'spec_helper'

describe GaragePolicy do
  subject { GaragePolicy.new(user, garage) }

  let(:garage) { FactoryGirl.create(:garage, country: 'Spain') }

  context "for an admin" do
    let(:user) { FactoryGirl.create(:admin) }
    it { should allow_action(:index)   }
    it { should allow_action(:create)  }
    it { should allow_action(:new)     }
    it { should allow_action(:update)  }
    it { should allow_action(:edit)    }
    it { should allow_action(:destroy) }
  end

  context "for a country_manager" do
    let(:user) { FactoryGirl.create(:country_manager, country: 'Spain') }
    it { should allow_action(:index)   }
    it { should allow_action(:create)  }
    it { should allow_action(:new)     }
    it { should allow_action(:update)  }
    it { should allow_action(:edit)    }
    it { should allow_action(:destroy) }
  end

  # context "for an owner" do
  #   let(:user) { FactoryGirl.create(:owner) }
  #   it { should_not allow_action(:index)   }
  #   it { should_not allow_action(:create)  }
  #   it { should_not allow_action(:new)     }
  #   it { should allow_action(:update)  }
  #   it { should allow_action(:edit)    }
  #   it { should_not allow_action(:destroy) }
  # end
end