class GarageDecorator < ApplicationDecorator
  def status
    return 'to_confirm' if object.to_be_confirmed?
    object.status == Garage::ACTIVE ? 'enabled' : 'disabled'
  end
end