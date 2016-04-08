class ServicePolicy < ApplicationPolicy
  def initialize(user, service)
    @user = user
    @service = service
  end

  def index?
    @user.owner?
  end

  def show?
    false
  end

  def new?
    false
  end

  def edit?
    false
  end

  def create?
    false
  end

  def update?
    false
  end

  def destroy?
    false
  end
end
