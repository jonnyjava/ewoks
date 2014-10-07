class UserMailer < ActionMailer::Base
  default from: EMAIL_ADMIN

  def send_generated_password(user)
    @user = user
    set_locale(@user)
    mail(to: user.email, subject: t('Your login for Ewoks'))
  end

  def send_changed_status_notification(user)
    @user = user
    set_locale(@user)
    mail(to: user.email, subject: t('Your account has been changed'))
  end

  private

  def set_locale(user)
    I18n.locale = Garage::COUNTRIES_WITH_LOCALE.key(user.garage.country)
  end
end
