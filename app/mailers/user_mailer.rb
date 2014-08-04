class UserMailer < ActionMailer::Base
  default from: EMAIL_ADMIN

  def send_generated_password(user)
    @user = user
    mail(to: user.email, subject: 'Your login for Ewoks')
  end

  def send_activation_notification(user)
    @user = user
    mail(to: user.email, subject: 'Your account has been activated')
  end
end
