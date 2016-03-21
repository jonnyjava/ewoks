module FiltrableByGarage
  class Scope
    attr_reader :user, :scope

    def initialize(user, scope)
      @user = user
      @scope = scope
    end

    def resolve
      if user.admin?
        scope.all
      elsif user.country_manager?
        scope.includes(:garage).where('garages.country = ?', user.country).references(:garage)
      else
        scope.where(garage_id: user.garage.id)
      end
    end
  end

  def index?
    false
  end

  def show?
    false
  end

  def new?
    @user.admin? || belong_to_country_manager_country? || belong_to_owner?
  end

  def edit?
    @user.admin? || belong_to_country_manager_country? || belong_to_owner?
  end

  def create?
    @user.admin? || belong_to_country_manager_country? || belong_to_owner?
  end

  def update?
    @user.admin? || belong_to_country_manager_country? || belong_to_owner?
  end

  def destroy?
    @user.admin? || belong_to_country_manager_country? || belong_to_owner?
  end

  private
    def belong_to_owner?
      @user.owner? && is_its_owner?
    end

    def belong_to_country_manager_country?
      @user.country_manager? && its_garage_country_is_country_manager_country?
    end

    def its_garage_country_is_country_manager_country?
      raise NotImplementedError
    end

    def is_its_owner?
      raise NotImplementedError
    end
end
