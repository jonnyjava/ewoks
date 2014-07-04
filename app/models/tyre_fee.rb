class TyreFee < ActiveRecord::Base
  belongs_to :fee

  RIMS = %w(steel aluminum)
  VEHICLES = %w(tourism car suv)
  DIAMETER_MAX = 30
  DIAMETER_MIN = 10

  DIAMETER = (DIAMETER_MIN..DIAMETER_MAX)

  RIM_TYPE = Hash[RIMS.map.with_index { |obj, i| [i, obj] } ]
  VEHICLE_TYPE = Hash[VEHICLES.map.with_index { |obj, i| [i, obj] } ]
end
