class GarageDecorator < Draper::Decorator
  delegate_all

  def status
    object.status? ? 'active' : 'disable'
  end
end
