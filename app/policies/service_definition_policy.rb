class ServiceDefinitionPolicy < ApplicationPolicy
  def initialize(user, service_definition)
    @user = user
    @service_definition = service_definition
  end

  def index?
    @user.admin?
  end

  def show?
    false
  end

  def new?
    @user.admin?
  end

  def edit?
    false
  end

  def create?
    @user.admin?
  end

  def update?
    @user.admin?
  end

  def destroy?
    @user.admin?
  end
end
