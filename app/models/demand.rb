class Demand < ActiveRecord::Base
  belongs_to :service_category
  belongs_to :service
  has_many :demands_garage
  has_many :garages, through: :demands_garage
  has_many :quote_proposals, dependent: :destroy
  validates :city, :name_and_surnames, :phone, :email, presence: true

  after_create :assign

  def assign
    assignable_garages = Garage.assignable_garages(self)
    garages << assignable_garages
    DemandMailer.no_assignables_alert(self).deliver_now if assignable_garages.empty?
  end

  def get_garage_association_id(garage)
    association = demands_garage.where(garage: garage).first
    return unless association.present?
    association.id
  end
end
