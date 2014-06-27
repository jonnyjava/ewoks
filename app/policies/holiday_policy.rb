class HolidayPolicy < ApplicationPolicy

  def initialize(user, holiday)
    @user = user
    @holiday = holiday
  end

  def index?
    @user.admin? || belongs_to_user_country?
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
    @user.country_manager? and (@user.country == @holiday.garage.country)
  end

  def belongs_to_user?
    @holiday.garage.owner_id == @user.id
  end
end
