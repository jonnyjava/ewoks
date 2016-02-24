class UserMailer < ActionMailer::Base
  include MailerHelper
  default from: EMAIL_ADMIN

  def send_generated_password(user)
    @user = user
    set_locale(@user.garage)
    mail(to: user.email, subject: t('Your login for 123Mecanico'))
  end

  def send_changed_status_notification(user)
    @user = user
    set_locale(@user.garage)
    mail(to: user.email, subject: t('Your account has been changed'))
  end
end
