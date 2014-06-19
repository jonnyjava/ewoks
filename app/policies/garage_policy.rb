class GaragePolicy  < Struct.new(:user, :garage)

  def initialize(user, garage)
    @user = user
    @garage = garage
  end

  def index?
    belongs_to_user_area?
  end

  def new?
    @user.admin?
  end

  def edit?
    @user.admin?
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

  def belongs_to_user_area?
    @user.admin? || (@user.country_manager? and @user.country == @garage.country)
  end
end