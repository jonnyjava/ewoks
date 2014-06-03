class Garage < ActiveRecord::Base
  has_many :holidays
  has_many :fees
  has_many :garage_properties
  has_many :properties, through: :garage_properties

  validates :address, :zip, :city, :country, :phone, :tax_id, presence: true
end
