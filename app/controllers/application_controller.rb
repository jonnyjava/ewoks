class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  include Pundit
  protect_from_forgery with: :exception
  before_action :authenticate_user!
  before_action :set_locale
  before_action :set_notifications

  rescue_from Pundit::NotAuthorizedError, with: :user_not_authorized

  private

  def user_not_authorized
    flash[:alert] = 'Access denied.'
    redirect_to user_path(current_user)
  end

  def set_locale
    I18n.locale = extract_locale_from_accept_language_header ||
    params[:locale] || I18n.default_locale
  end

  def default_url_options(options = {})
    { locale: I18n.locale }.merge options
  end

  def extract_locale_from_accept_language_header
    language = request.env['HTTP_ACCEPT_LANGUAGE']
    language.scan(/^[a-z]{2}/).first if language
  end

  def set_notifications
    return unless current_user.owner?
    @notifications = current_user.garage.decorate.notifications
  end
end
