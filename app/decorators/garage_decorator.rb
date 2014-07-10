class GarageDecorator < ApplicationDecorator
  def status
    object.status? ? 'active' : 'disable'
  end
end
