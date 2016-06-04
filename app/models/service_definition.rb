class ServiceDefinition < ActiveRecord::Base
  belongs_to :service
  validates :name, presence: true
  scope :assigned, ->(){ where.not(service_id: nil) }
  scope :not_assigned, ->(){ where(service_id: nil) }
end
