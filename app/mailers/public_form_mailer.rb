class PublicFormMailer < ActionMailer::Base
  default from: EMAIL_ADMIN

  def signup_confirmation(garage)
    @garage = garage
    mail(to: garage.email, subject: 'Welcome to Ewoks')
  end
end