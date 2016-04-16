module ApplicationHelper
  def status_label(object)
    color = COLORS[object.class.send(:statuses)[object.status]] || 'primary'
    "label-#{color}"
  end
end
