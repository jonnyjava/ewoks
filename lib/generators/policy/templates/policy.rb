class <%= class_name %>Policy < ApplicationPolicy
  def initialize(user, <%= singular_table_name %>)
    @user = user
    @<%= singular_table_name %> = <%= singular_table_name %>
  end

  def index?
    false
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
