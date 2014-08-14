class TimetablePolicy < ApplicationPolicy

  def initialize(user, timetable)
    @user = user
    @timetable = timetable
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
    @user.country_manager? and (@user.country == @timetable.garage.country)
  end

  def belongs_to_user?
    @timetable.garage.owner_id == @user.id
  end
end
