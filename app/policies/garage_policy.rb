class GaragePolicy < ApplicationPolicy

  def initialize(user, garage)
    @user = user
    @garage = garage
  end

  def index?
    @user.admin? || belongs_to_user_country?
  end

  def show?
    @user.admin? || belongs_to_user_country? || belongs_to_user?
  end

  def new?
    @user.admin? || belongs_to_user_country?
  end

  def edit?
    @user.admin? || belongs_to_user_country? || belongs_to_user?
  end

  def create?
    @user.admin? || belongs_to_user_country?
  end

  def toggle_status?
    @user.admin?
  end

  def update?
    @user.admin? || belongs_to_user_country? || belongs_to_user?
  end

  def destroy?
    @user.admin?
  end

  def belongs_to_user_country?
    @user.country_manager? and (@garage.blank? || (@user.country == @garage.country))
  end

  def belongs_to_user?
    @garage.owner_id == @user.id
  end
end