class Garage < ActiveRecord::Base
  has_many :holidays
  has_many :fees
  has_and_belongs_to_many :properties
end
