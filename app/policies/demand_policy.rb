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
        @user.demands
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
    false
  end

  def create?
    @user.api?
  end

  def update?
    false
  end

  def destroy?
    false
  end
end
