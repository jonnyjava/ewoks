class ServiceCategory < ActiveRecord::Base
  has_many :services, dependent: :destroy
  validates :name, presence: true
end
