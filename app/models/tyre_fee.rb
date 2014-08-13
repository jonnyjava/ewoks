class TyreFee < ActiveRecord::Base
  belongs_to :garage

  validates :name, presence: true
  validates :price, presence: true

  RIMS = %w(steel aluminum)
  VEHICLES = %w(tourism car suv)
  DIAMETER_MAX = 30
  DIAMETER_MIN = 10

  DIAMETER = (DIAMETER_MIN..DIAMETER_MAX)

  RIM_TYPE = Hash[RIMS.map.with_index { |obj, i| [i, obj] }]
  VEHICLE_TYPE = Hash[VEHICLES.map.with_index { |obj, i| [i, obj] }]

  scope :by_garage, ->(garage) { joins(:fee).where('garage_id = ?', garage.id) }
  scope :by_diameter, ->(diameter) { where('diameter_min >= ?', diameter).where('diameter_max <= ?', diameter) }
  scope :by_rim, ->(rim_type) { where(rim_type: rim_type) }
  scope :by_vehicle, ->(vehicle_type) { where(vehicle_type: vehicle_type)  }

  scope :by_price, ->(price) { joins(:fee).where('price = ?', price) }
  scope :with_price_less_than, ->(price) { where('price <= ?', price) }
end
