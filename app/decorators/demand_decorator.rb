class DemandDecorator < ApplicationDecorator

  def collapsed_text
    object.comments.first(18)
  end

  def collapsable_text
    comments
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
    "#{object.brand} #{object.model} (#{object.year})".gsub(/\(\)/,'').strip
  end

  def engine_details
    "#{object.engine} #{object.engine_letters}"
  end

  def car_complete_info
    "#{car_details} - #{engine_details}"
  end

  def self.categories
    h.options_from_collection_for_select(ServiceCategory.all, 'id', 'name')
  end

  def self.services
    h.options_from_collection_for_select(Service.all, 'id', 'name')
  end
end
