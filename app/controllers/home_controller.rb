class HomeController < ApplicationController
  before_filter :authenticate_user!, only: :already_registered
  skip_authorization_check

  def index
    render  'home/index'
  end

  def already_registered
    render layout: 'application'
  end

  rescue_from CanCan::AccessDenied do |exception|
    redirect_to root_url, alert: exception.message
  end
end
