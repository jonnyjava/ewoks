module GarageRecruitableHelper
  def recruitable_status_label(status)
    "label-#{COLORS[GarageRecruitable.statuses[status]]}"
  end
end
