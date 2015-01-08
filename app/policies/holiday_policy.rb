class HolidayPolicy < ApplicationPolicy
  def initialize(user, holiday)
    @user = user
    @holiday = holiday
  end

  class Scope
    attr_reader :user, :scope

    def initialize(user, scope)
      @user = user
      @scope = scope
    end

    def resolve
      if user.admin?
        scope.all
      elsif user.country_manager?
        scope.includes(:garage).where('garages.country = ?', user.country).references(:garage)
      else
        scope.where(garage_id: user.garage.id)
      end
    end
  end

  def index?
    @user.admin? || @user.country_manager? || @user.owner?
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