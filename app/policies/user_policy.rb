class UserPolicy < Struct.new(:user, :user)

  def initialize(logged_user, user)
    @logged_user = logged_user
    @user = user
  end

  def index?
    @logged_user.admin? || belongs_to_logged_user_country?
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

  def belongs_to_logged_user_country?
    @logged_user.country_manager? and (@logged_user.country == @user.country)
  end

  def is_himself?
    @logged_user == @user
  end
end
