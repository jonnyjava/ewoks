module GarageRecruitableHelper
  COLORS = Hash[%w(success info warning danger).map.with_index { |obj, i| [i, obj] }]

  def status_label(status)
    "label-#{COLORS[GarageRecruitable.statuses[status]]}"
  end

  def value_of_param_in?(params, param)
    params[:garage_recruitable].try(:[], param.to_sym)
  end

  def translated_statuses
    GarageRecruitable.statuses.map {|k,v| [t(k), k]}
  end

  def options_for_statuses(default)
    options_for_select(translated_statuses, default)
  end

  def select_status(name, default, options)
    select_tag("garage_recruitable[#{name}]", options_for_statuses(default), options)
  end

  def filter_tag(type, extra_options = {})
    options =  { placeholder: "#{t('filter_by')} #{t(type)}", class: 'form-control js_searchable' }.merge( extra_options )
    text_field_tag("garage_recruitable[#{type}]", value_of_param_in?(params, type), options )
  end
end
