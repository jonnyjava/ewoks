class ApplicationDecorator < Draper::Decorator
  delegate_all

  def pathify(action, *entity)
    action << "_" unless action === ''
    action << entity.first.class.name.underscore << "_" if entity.present?
    action << self.source.class.name.underscore

    "#{action}_path"
  end
end
