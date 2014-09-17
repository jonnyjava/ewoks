class TyreFee < ActiveRecord::Base
  belongs_to :garage

  validates :name, presence: true
  validates :price, presence: true

  RIMS = %w(steel aluminium)
  VEHICLES = %w(tourism suv van)
  DIAMETER_MAX = 30
  DIAMETER_MIN = 10

  DIAMETER = (DIAMETER_MIN..DIAMETER_MAX)

  RIM_TYPE = Hash[RIMS.map.with_index { |obj, i| [i, obj] }]
  VEHICLE_TYPE = Hash[VEHICLES.map.with_index { |obj, i| [i, obj] }]

  scope :by_garage, ->(garage) { where(garage_id: garage.id) }
  scope :by_diameter, ->(diameter) { where('diameter_min <= ?', diameter).where('diameter_max >= ?', diameter) if diameter}
  scope :by_rim, ->(rim) { where(rim_type: RIM_TYPE.key(rim)) if rim}
  scope :by_vehicle, ->(vehicle) { where(vehicle_type: vehicle) if vehicle }
  scope :by_price, ->(price) { where(price: price) if price}
  scope :by_price_in_a_range, ->(min_price, max_price) { where(price: min_price..max_price) }
end
