class UserPolicy < ApplicationPolicy
  def initialize(logged_user, user)
    @logged_user = logged_user
    @user = user
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
        scope.where(country: logged_user.country, role: User::OWNER)
      else
        logged_user
      end
    end
  end

  def index?
    @logged_user.admin? || @logged_user.country_manager?
  end

  def show?
    @logged_user.admin? || belongs_to_logged_user_country? || is_himself?
  end

  def new?
    @logged_user.admin?
  end

  def edit?
    @logged_user.admin? || belongs_to_logged_user_country? || is_himself?
  end

  def create?
    @logged_user.admin?
  end

  def update?
    @logged_user.admin? || belongs_to_logged_user_country? || is_himself?
  end

  def destroy?
    @logged_user.admin?
  end

  def regenerate_auth_token?
    @logged_user.admin? || belongs_to_logged_user_country? || is_himself?
  end

  def belongs_to_logged_user_country?
    @logged_user.country_manager? and (@user.blank? || (@logged_user.country == @user.try(:country)))
  end

  def is_himself?
    @logged_user == @user
  end
end
