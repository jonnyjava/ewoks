class GarageDecorator < ApplicationDecorator
  include Draper::ViewHelpers

  def notifications
    items = []

    add_missing_holidays_notification(items) unless object.holidays.present?
    add_missing_timetable_notification(items) unless object.timetable.present?
    add_missing_services_notification(items) unless object.services.present?

    h.content_tag :ul, class: 'menu' do
      items.map { |item| h.concat(h.content_tag(:li, item)) }
    end if items.length > 0
  end

  private

  def add_missing_holidays_notification(items)
    items << h.link_to("/garages/#{object.id}/holidays") do
      h.concat h.content_tag(:i, nil, class: 'ion ion-calendar warning')
      h.concat h.t('set_your_holidays')
    end
    items
  end

  def add_missing_timetable_notification(items)
    items << h.link_to(
      "/garages/#{object.id}/timetables/#{object.timetable.try(:id)}/edit") do
      h.concat h.content_tag(:i, nil, class: 'ion ion-clock danger')
      h.concat h.t('Define the opening hours')
    end
    items
  end

  def add_missing_services_notification(items)
    items << h.link_to("/services") do
      h.concat h.content_tag(:i, nil, class: 'fa fa-cogs danger')
      h.concat h.t('set_your_services')
    end
    items
  end

end
