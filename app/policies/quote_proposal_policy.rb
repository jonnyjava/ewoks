class QuoteProposalPolicy < ApplicationPolicy
  def initialize(user, quote_proposal)
    @user = user
    @quote_proposal = quote_proposal
  end

  class Scope
    attr_reader :user, :scope

    def initialize(user, scope)
      @user = user
      @scope = scope
    end

    def resolve
      if user.admin?
        scope.all
      elsif user.owner?
        scope.where(garage: @user.garage)
      else
        scope.none
      end
    end
  end

  def index?
    @user.admin? || all_demands_are_associated_to_garage_owner? || authorized_owner?
  end

  def show?
    @user.admin? || authorized_owner?
  end

  def new?
    authorized_owner?
  end

  def edit?
    @user.admin? || authorized_owner?
  end

  def create?
    authorized_owner?
  end

  def update?
    @user.admin? || authorized_owner? || @user.api?
  end

  def destroy?
    @user.admin? || authorized_owner?
  end

  private
    def all_demands_are_associated_to_garage_owner?
      return false unless @user.owner?
      return false unless @quote_proposal.try(:all?)
      garages = @quote_proposal.pluck(:garage_id).uniq
      garages.size == 1 && (@user.garage.id == garages.first)
    end

    def authorized_owner?
      @user.owner? && demand_is_associated_to_garage_owner?
    end

    def demand_is_associated_to_garage_owner?
      return true if @quote_proposal.blank?
      @quote_proposal.demands_garage.try(:garage) && @quote_proposal.demands_garage.garage == @user.garage
    end
end
