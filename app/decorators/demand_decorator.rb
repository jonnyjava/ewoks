class DemandDecorator < ApplicationDecorator

  def shortened_comment
    object.comments.first(18)
  end

  def service_category_name
    object.service_category.name
  end

  def service_name
    object.service.name
  end

  def service_with_category
    "#{service_category_name} - #{service_name}"
  end

  def car_details
    "#{object.brand} #{object.model} (#{object.year})"
  end

  def engine_details
    "#{object.engine} #{object.engine_letters}"
  end

  def car_complete_info
    "#{car_details} - #{engine_details}"
  end
end
