module DemandHelper

  def new_quote_path(demand, user)
    association_id = demand.get_garage_association_id(user.garage)
    return unless association_id.present?
    new_quote_proposals_path(association_id)
  end
end
