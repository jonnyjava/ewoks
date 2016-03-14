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
    @logged_user.admin? || belongs_to_country_manager_country?
  end

  def show?
    @logged_user.admin? || belongs_to_country_manager_country? || is_himself?
  end

  def new?
    @logged_user.admin?
  end

  def edit?
    @logged_user.admin? || belongs_to_country_manager_country? || is_himself?
  end

  def create?
    @logged_user.admin?
  end

  def update?
    @logged_user.admin? || belongs_to_country_manager_country? || is_himself?
  end

  def destroy?
    @logged_user.admin?
  end

  def regenerate_auth_token?
    @logged_user.admin? || (@user.api? && is_himself?)
  end

  private
    def belongs_to_country_manager_country?
      @logged_user.country_manager? && (is_himself? || is_owner?) && share_the_same_country?
    end

    def is_himself?
      @logged_user == @user
    end

    def is_owner?
      (@user.try(:role) && @user.owner?) || (@user.try(:all?) && @user.all?(&:owner?))
    end

    def share_the_same_country?
      (@logged_user.try(:country) == @user.try(:country)) || (@user.try(:all?) && @user.all?{|s| s.country == @logged_user.country})
    end
end
