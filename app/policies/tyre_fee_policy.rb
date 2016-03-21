class TyreFeePolicy < ApplicationPolicy
  include FiltrableByGarage

  def initialize(user, tyre_fee)
    @user = user
    @authorizable = tyre_fee
  end

  def index?
    @user.admin? || all_belong_to_country_manager_country? || belong_to_owner?
  end
end
