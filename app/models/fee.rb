class Fee < ActiveRecord::Base
  belongs_to :garage
  validates :name, presence: true
  validates :price, presence: true

  def tyre_fee
    TyreFee.where(fee_id: id).first
  end
end
