class GarageRecruitableDecorator < ApplicationDecorator
  def complete_address
    "#{object.street}, #{object.zip}, #{object.city} - #{object.province}"
  end

  def complete_contacts
    "#{object.phone} - #{object.mobile}"
  end

  def self.translated_statuses
    GarageRecruitable.statuses.map { |k, v| [I18n.translate(k), v] }
  end
end
