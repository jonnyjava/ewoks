class DemandPolicy < ApplicationPolicy
  def initialize(user, demand)
    @user = user
    @demand = demand
  end

  class Scope
    attr_reader :user, :scope

    def initialize(user, scope)
      @user = user
      @scope = scope
    end

    def resolve
      if user.owner?
        @user.unanswered_demands
      else
        scope.all
      end
    end
  end

  def index?
    @user.admin? || @user.owner?
  end

  def show?
    @user.admin? || @user.owner?
  end

  def new?
    false
  end

  def edit?
    @user.admin?
  end

  def create?
    @user.api?
  end

  def update?
    @user.admin?
  end

  def destroy?
    @user.admin?
  end
end
