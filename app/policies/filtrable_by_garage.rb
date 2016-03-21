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

    def all_belong_to_country_manager_country?
      all_garages_country_eq_country_manager_country? || belong_to_country_manager_country?
    end

    def all_garages_country_eq_country_manager_country?
      return false unless @authorizable.try(:all?)
      return false unless @user.country_manager?
      countries = @authorizable.map(&:garage).map(&:country).uniq
      countries.size == 1 && countries.first == @user.country
    end

    def is_its_owner?
      return true if @authorizable.blank?
      return @authorizable.garage.owner_id == @user.id if @authorizable.try(:garage)
      garages = @authorizable.pluck(:garage_id).uniq
      (garages.size == 1) && (garages.first == @user.garage.id)
    end

    def its_garage_country_is_country_manager_country?
      return true if @authorizable.blank?
      @user.country == @authorizable.garage.country
    end
end
