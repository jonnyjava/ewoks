class CurrencyInput < SimpleForm::Inputs::Base
  include ActionView::Helpers::NumberHelper

  def input(wrapper_options)
    template.content_tag(:div, class: 'input-group') do
      template.concat @builder.text_field(attribute_name, input_html_options)
      template.concat span_icon
    end
  end

  def input_html_options
    super.merge(class: 'form-control',
                title: input_title,
                pattern: input_pattern,
                value: input_value,
                placeholder: I18n.translate(attribute_name))
  end

  def input_title
    I18n.t('valid_price')
  end

  def input_pattern
    '^[0-9\.*]{1,6}(,[0-9]{1,2})*$'
  end

  def input_value
    value = @builder.object.send(attribute_name)
    number_to_currency(value, unit: "", separator:",", delimiter: "", format: "%n%u")
  end

  def span_icon
    template.content_tag(:span, class: 'input-group-addon add-on') do
      template.concat icon_euro
    end
  end

  def icon_euro
    "<i class='fa fa-eur'></i>".html_safe
  end
end
