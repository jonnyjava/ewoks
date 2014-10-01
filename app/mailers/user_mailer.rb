class UserMailer < ActionMailer::Base
  default from: EMAIL_ADMIN

  def send_generated_password(user)
    @user = user
    mail(to: user.email, subject: t('Your login for Ewoks'))
  end

  def send_changed_status_notification(user)
    @user = user
    mail(to: user.email, subject: t('Your account has been changed'))
  end
end
