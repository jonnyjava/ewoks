class GarageRecruitablePolicy < ApplicationPolicy
  def initialize(user, garage_recruitable)
    @user = user
    @garage_recruitable = garage_recruitable
  end

  def index?
    @user.admin? || @user.country_manager?
  end

  def show?
    @user.admin? || @user.country_manager?
  end

  def new?
    @user.admin? || @user.country_manager?
  end

  def edit?
    @user.admin? || @user.country_manager?
  end

  def create?
    @user.admin? || @user.country_manager?
  end

  def update?
    @user.admin? || @user.country_manager?
  end

  def destroy?
    @user.admin? || @user.country_manager?
  end
end
