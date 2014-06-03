class GarageProperty < ActiveRecord::Base
  belongs_to :garage
  belongs_to :property
end
