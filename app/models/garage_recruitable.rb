class GarageRecruitable < ActiveRecord::Base
  enum status: [ :recruitable, :recruited, :has_bounced_us, :waiting_for_answer ]

  validates :name, :tax_id, presence: true
  validates :tax_id, uniqueness: true
end
