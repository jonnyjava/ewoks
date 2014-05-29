class HomeController < ApplicationController
  before_filter :authenticate_user!, :only => :already_registered

  def index
    render  'home/index'
  end

  def already_registered
    render :layout => 'application'
  end
end
