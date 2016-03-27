class CalendarInput < SimpleForm::Inputs::Base
  def input(wrapper_options)
    template.content_tag(:div, class: 'input-group') do
      template.concat @builder.text_field(attribute_name, input_html_options)
      template.concat span_icon
    end
  end

  def input_html_options
    super.merge({class: 'form-control js-datepicker'})
  end

  def span_icon
    template.content_tag(:span, class: 'input-group-addon add-on') do
      template.concat icon_euro
    end
  end

  def icon_euro
    "<i class='fa fa-calendar'></i>".html_safe
  end
end
