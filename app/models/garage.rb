class Garage < ActiveRecord::Base
  belongs_to :user, foreign_key: "owner_id"
  has_many :holidays
  has_many :fees
  has_many :garage_properties
  has_many :properties, through: :garage_properties

  validates :address, :zip, :city, :country, :phone, :tax_id, presence: true

  has_attached_file :logo, default_url: "/assets/avatar_default.jpg"
  validates_attachment_content_type :logo, content_type: ['image/png', 'image/jpg']
end
