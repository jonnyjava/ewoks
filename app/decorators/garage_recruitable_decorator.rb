class GarageRecruitableDecorator < ApplicationDecorator
  def complete_address
    "#{object.street}, #{object.zip}, #{object.city} - #{object.province}"
  end

  def self.statuses
    GarageRecruitable.statuses.map {|k,v| [ I18n.translate(k), k ]}
  end
end
