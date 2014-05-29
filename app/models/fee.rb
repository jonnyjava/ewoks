class Fee < ActiveRecord::Base
  belongs_to :garage
  validates :price, presence: true
end
