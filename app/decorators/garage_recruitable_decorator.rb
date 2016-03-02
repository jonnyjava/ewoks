class GarageRecruitableDecorator < ApplicationDecorator
  COLORS = Hash[%w(success info danger warning).map.with_index { |obj, i| [i, obj] }]
  def complete_address
    "#{object.street}, #{object.zip}, #{object.city} - #{object.province}"
  end

  def complete_contacts
    "#{object.phone} - #{object.mobile}"
  end

  def set_label_color
    "label-#{COLORS[GarageRecruitable.statuses[object.status]]}"
  end

  def self.statuses
    GarageRecruitable.statuses.map {|k,v| [ I18n.translate(k), k ]}
  end
end
