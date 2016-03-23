class Demand < ActiveRecord::Base
  belongs_to :service_category
  belongs_to :service
  has_and_belongs_to_many :garages
  validates :city, :name_and_surnames, :phone, :email, presence: true

  after_create :assign

  def assign
    garages << Garage.assignable_garages(self)
  end
end
