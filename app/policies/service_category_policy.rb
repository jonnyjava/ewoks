class ServiceCategoryPolicy < ApplicationPolicy
  def initialize(user, service_category)
    @user = user
    @service_category = service_category
  end

  def index?
    @user.admin?
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
