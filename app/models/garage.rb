class Garage < ActiveRecord::Base
  belongs_to :user, foreign_key: "owner_id"
  has_many :holidays
  has_many :fees
  has_and_belongs_to_many :properties

  validates :address, :zip, :city, :country, :phone, :tax_id, presence: true
end
