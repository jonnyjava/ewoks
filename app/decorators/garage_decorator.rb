class GarageDecorator < ApplicationDecorator
  def status
    object.status? ? 'enabled' : 'disabled'
  end
end