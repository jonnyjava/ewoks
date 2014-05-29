class Holiday < ActiveRecord::Base
  belongs_to :garage
  validates :start_date, presence: true
end
