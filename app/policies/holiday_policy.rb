class HolidayPolicy < ApplicationPolicy
  include FiltrableByGarage

  def initialize(user, holiday)
    @user = user
    @authorizable = holiday
  end

  def index?
    @user.admin? || all_belong_to_country_manager_country? || belong_to_owner?
  end

  def show?
    @user.admin? || belong_to_country_manager_country? || belong_to_owner?
  end
end
