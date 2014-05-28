class Garage < ActiveRecord::Base
  has_many :holidays
  has_many :fees
end
