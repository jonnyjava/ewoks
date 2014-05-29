class Garage < ActiveRecord::Base
  has_many :holidays
  has_many :fees
  has_and_belongs_to_many :properties

  validates :address, :zip, :city, :country, :phone, :tax_id, presence: true
end
