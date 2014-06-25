class Fee < ActiveRecord::Base
  belongs_to :garage
  validates :name, presence: true
  validates :price, presence: true
end
