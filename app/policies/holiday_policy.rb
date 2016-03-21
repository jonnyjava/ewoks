class HolidayPolicy < ApplicationPolicy
  include FiltrableByGarage

  def initialize(user, holiday)
    @user = user
    @holiday = holiday
  end

  def index?
    @user.admin? || all_belong_to_country_manager_country? || belong_to_owner?
  end

  def show?
    @user.admin? || belong_to_country_manager_country? || belong_to_owner?
  end

  private
    def is_its_owner?
      return true if @holiday.blank?
      return @holiday.garage.owner_id == @user.id if @holiday.try(:garage)
      garages = @holiday.pluck(:garage_id).uniq
      (garages.size == 1) && (garages.first == @user.garage.id)
    end

    def its_garage_country_is_country_manager_country?
      @user.country == @holiday.garage.country
    end

    def all_belong_to_country_manager_country?
      belong_to_country_manager_country? || all_garages_country_eq_country_manager_country?
    end

    def all_garages_country_eq_country_manager_country?
      return false unless @holiday.try(:all?)
      return false unless @user.country_manager?
      countries = @holiday.map(&:garage).map(&:country).uniq
      countries.size == 1 && countries.first == @user.country
    end
end
