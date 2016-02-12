module MailerHelper
  def set_locale(localizable)
    I18n.locale = COUNTRIES_WITH_LOCALE.key(localizable.try(:country)) || :es
  end
end
