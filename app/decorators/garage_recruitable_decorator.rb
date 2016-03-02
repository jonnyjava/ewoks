class GarageRecruitableDecorator < ApplicationDecorator
  def complete_address
    "#{object.street}, #{object.zip}, #{object.city} - #{object.province}"
  end

  def complete_contacts
    "#{object.phone} - #{object.mobile}"
  end
end
