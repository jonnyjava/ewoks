class Holiday < ActiveRecord::Base
  belongs_to :garage
  validates :start_date, presence: true

  scope :not_in_holiday, ->(date) { where.not('? BETWEEN start_date and end_date', date) if date }
end
