class Property < ActiveRecord::Base
  has_many :garage_properties
  has_many :garages, through: :garage_properties
end
