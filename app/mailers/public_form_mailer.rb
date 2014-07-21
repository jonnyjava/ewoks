class PublicFormMailer < ActionMailer::Base
  default from: EMAIL_ADMIN

  def sing_up_confirmation(email)
    mail(to: email, subject: 'Welcome to Ewoks')
  end
end
