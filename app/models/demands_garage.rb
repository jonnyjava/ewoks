class DemandsGarage < ActiveRecord::Base
  belongs_to :demand
  belongs_to :garage
  has_one :quote_proposal

  after_create :notify_my_garage

  def notify_my_garage
    return unless garage
    GarageMailer.notify_demand(garage, demand).deliver_now
  end
end
