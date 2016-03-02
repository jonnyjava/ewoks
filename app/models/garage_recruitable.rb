class GarageRecruitable < ActiveRecord::Base
  enum status: [ :recruitable, :recruited, :has_bounced_us, :waiting_for_answer ]

  validates :name, :tax_id, presence: true
  validates :tax_id, uniqueness: true
  scope :filter_by, ->(param, value) { where("lower(#{param}) LIKE ?", "%#{value.downcase}%") if method_defined?(param) && value && !(columns_hash[param].type == :integer) }
  scope :by_status, ->(status) { where(status: statuses[status]) if status }
end
