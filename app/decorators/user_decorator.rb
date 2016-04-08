class UserDecorator < ApplicationDecorator
  def complete_name
    "#{name} #{surname}"
  end
end
