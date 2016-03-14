class TimetablePolicy < ApplicationPolicy
  include FiltrableByGarage

  def initialize(user, timetable)
    @user = user
    @timetable = timetable
  end

  def index?
    false
  end

  def show?
    false
  end

  private
    def is_its_owner?
      @timetable.garage.owner_id == @user.id
    end

    def its_garage_country_is_country_manager_country?
      @user.country == @timetable.garage.country
    end
end
