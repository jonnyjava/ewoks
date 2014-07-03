class GaragePolicy < ApplicationPolicy

  def initialize(user, garage)
    @user = user
    @garage = garage
  end

  class Scope
    attr_reader :logged_user, :scope

    def initialize(logged_user, scope)
      @logged_user = logged_user
      @scope = scope
    end

    def resolve
      if logged_user.admin?
        scope.all
      elsif logged_user.country_manager?
        scope.where(country: logged_user.country)
      else
        scope.where(owner_id: logged_user)
      end
    end
  end

  def index?
    @user.admin? || @user.country_manager?
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

  def destroy_logo?
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