class GarageDecorator < ApplicationDecorator
  include Draper::ViewHelpers

  def status
    return 'to_confirm' if object.to_be_confirmed?
    object.status == Garage::ACTIVE ? 'enabled' : 'disabled'
  end

  def notifications
    items = []

    items << h.link_to("/garages/#{object.id}/tyre_fees") do
      h.concat h.content_tag(:i, nil, class: 'ion ion-pricetags danger')
      h.concat h.t('Add rates tires')
    end if object.tyre_fees.blank?

    items << h.link_to("/garages/#{object.id}/holidays") do
      h.concat h.content_tag(:i, nil, class: 'ion ion-calendar warning')
      h.concat h.t('Indicate vacation days')
    end if object.holidays.blank?

    items << h.link_to(
      "/garages/#{object.id}/timetables/#{object.timetable.try(:id)}/edit") do
      h.concat h.content_tag(:i, nil, class: 'ion ion-clock danger')
      h.concat h.t('Define the opening hours')
    end if object.timetable.blank?

    h.content_tag :ul, class: 'menu' do
      items.map { |item| h.concat(h.content_tag(:li, item)) }
    end if items.length > 0
  end
end
