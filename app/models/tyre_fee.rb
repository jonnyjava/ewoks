class TyreFee < Fee

  DIAMETER_MAX = 30
  DIAMETER_MIN = 10

  DIAMETER = (DIAMETER_MIN..DIAMETER_MAX)
  RIM_TYPE = ["steel", "aluminum"]
  VEHICLE_TYPE = ["tourism", "car", "suv"]
end
