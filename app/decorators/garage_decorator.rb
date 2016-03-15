class GarageDecorator < ApplicationDecorator
  include Draper::ViewHelpers

  def status
    return 'to_confirm' if object.to_confirm?
    object.active? ? 'enabled' : 'disabled'
  end

  def notifications
    items = []

    add_missing_tyre_fee_notification(items) unless object.tyre_fees.present?
    add_missing_holidays_notification(items) unless object.holidays.present?
    add_missing_timetable_notification(items) unless object.timetable.present?

    h.content_tag :ul, class: 'menu' do
      items.map { |item| h.concat(h.content_tag(:li, item)) }
    end if items.length > 0
  end

  private

  def add_missing_tyre_fee_notification(items)
    items << h.link_to("/garages/#{object.id}/tyre_fees") do
      h.concat h.content_tag(:i, nil, class: 'ion ion-pricetags danger')
      h.concat h.t('Add rates tires')
    end
    items
  end

  def add_missing_holidays_notification(items)
    items << h.link_to("/garages/#{object.id}/holidays") do
      h.concat h.content_tag(:i, nil, class: 'ion ion-calendar warning')
      h.concat h.t('Indicate vacation days')
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

end
