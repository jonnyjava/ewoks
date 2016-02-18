require 'spec_helper'

describe GarageRegistration do

  context "with a valid input" do
    it "should create a new user and a new garage" do
      garage_registration = FactoryGirl.build(:garage_registration)
      users = User.count
      garages = Garage.count
      garage_registration.save
      expect(User.count).to be(users+1)
      expect(Garage.count).to be(garages+1)
    end
  end

  context "with an invalid input" do
    it "should not create a new user nor a new garage" do
      garage_registration = FactoryGirl.build(:garage_registration, name: nil, email: nil)
      users = User.count
      garages = Garage.count
      expect(garage_registration).to_not be_valid

      garage_registration.save
      expect(User.count).to be(users)
      expect(Garage.count).to be(garages)
    end
  end
end
