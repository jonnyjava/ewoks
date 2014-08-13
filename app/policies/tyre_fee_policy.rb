class TyreFeePolicy < ApplicationPolicy

  def initialize(user, tyre_fee)
    @user = user
    @tyre_fee = tyre_fee
  end

  def show?
    @user.admin? || belongs_to_user_country? || belongs_to_user?
  end

  def new?
    @user.admin? || belongs_to_user_country? || belongs_to_user?
  end

  def edit?
    @user.admin? || belongs_to_user_country? || belongs_to_user?
  end

  def create?
    @user.admin? || belongs_to_user_country? || belongs_to_user?
  end

  def update?
    @user.admin? || belongs_to_user_country? || belongs_to_user?
  end

  def destroy?
    @user.admin? || belongs_to_user_country? || belongs_to_user?
  end

  def belongs_to_user_country?
    @user.country_manager? and (@user.country == @tyre_fee.garage.country)
  end

  def belongs_to_user?
    @tyre_fee.garage.owner_id == @user.id
  end
end
