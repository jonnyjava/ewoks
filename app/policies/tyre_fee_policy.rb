class TyreFeePolicy < ApplicationPolicy
  include FiltrableByGarage

  def initialize(user, tyre_fee)
    @user = user
    @tyre_fee = tyre_fee
  end

  def index?
    false
  end

  def show?
    @user.admin? || belong_to_country_manager_country? || belong_to_owner?
  end

  private
    def is_its_owner?
      return true if @tyre_fee.blank?
      return @tyre_fee.garage.owner_id == @user.id if @tyre_fee.try(:garage)
      garages = @tyre_fee.pluck(:garage_id).uniq
      (garages.size == 1) && (garages.first == @user.garage.id)
    end

    def its_garage_country_is_country_manager_country?
      @user.country == @tyre_fee.garage.country
    end
end
