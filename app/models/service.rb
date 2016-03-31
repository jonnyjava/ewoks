class Service < ActiveRecord::Base
  belongs_to :service_category
  has_and_belongs_to_many :garages
  before_destroy { garages.clear }

  validates :name, presence: true
end
