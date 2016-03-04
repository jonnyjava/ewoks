class GarageRecruitable < ActiveRecord::Base
  enum status: [ :recruitable, :waiting_for_answer, :unreachable, :dismissed ]

  validates :name, :email, :tax_id, presence: true
  validates :tax_id, uniqueness: true

  after_create :set_token

  scope :filter_by, ->(param, value) { where("lower(#{param}) LIKE ?", "%#{value.downcase}%") if method_defined?(param) && value && !(columns_hash[param].type == :integer) }
  scope :by_status, ->(status) { where(status: statuses[status]) if status }

  def recruiting_token
    token = [email, tax_id, 'Let The Wookiee Win', name].join
    Digest::SHA1.hexdigest(token)
  end

  def set_token
    self.update_attribute(:token, recruiting_token)
  end

  def self.fill_empty_token
    GarageRecruitable.where(token: nil).each{|recruitable| recruitable.set_token }
  end
end
