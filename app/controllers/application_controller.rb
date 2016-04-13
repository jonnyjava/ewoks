class ApplicationController < ActionController::Base
  include Pundit
  protect_from_forgery with: :exception
  before_action :authenticate_user!
  before_action :set_locale
  before_action :set_notifications, :get_pending_demands

  rescue_from Pundit::NotAuthorizedError, with: :user_not_authorized

  def fetch_country_from_locale(locale)
    COUNTRIES_WITH_LOCALE.fetch(locale.to_s)
  end

  def fetch_locale_from_country(country)
    COUNTRIES_WITH_LOCALE.key(country)
  end

  private

  def user_not_authorized
    flash[:alert] = 'Access denied.'
    redirect_to user_path(current_user)
  end

  def set_locale
    I18n.locale = fetch_locale_from_country(current_user.try(:country)) || params[:locale] || extract_locale_from_accept_language_header || I18n.default_locale
  end

  def default_url_options(options = {})
    { locale: nil }.merge options
  end

  def extract_locale_from_accept_language_header
    language = request.env['HTTP_ACCEPT_LANGUAGE']
    language.scan(/^[a-z]{2}/).first if language
  end

  def set_notifications
    return unless current_user && current_user.owner?
    @notifications = current_user.garage.decorate.notifications
  end

  def get_pending_demands
    return unless current_user && current_user.owner?
    @pending_demands = current_user.garage.unanswered_demands
  end
end
