class PublicFormMailer < ActionMailer::Base
  default from: EMAIL_ADMIN

  def sing_up_confirmation(garage)
    @garage = garage
    mail(to: garage.email, subject: 'Welcome to Ewoks')
  end
end
