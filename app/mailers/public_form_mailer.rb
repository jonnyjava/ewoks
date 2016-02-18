require 'sendinblue'

class PublicFormMailer < ActionMailer::Base
  include MailerHelper
  default from: EMAIL_ADMIN

  def signup_confirmation(garage)
    @garage = garage
    set_locale(garage)
    send_confirmation_via_sendiblue || send_confirmation_via_gmail
  end

  private

  def send_confirmation_via_sendiblue
    return false unless Rails.env.production?
    sendinblue_mailer = Sendinblue::Mailin.new(ENV["SENDINBLUE_API_URL"], ENV["SENDINBLUE_API_TOKEN"])
    data = build_data_for_sendinblue_mailer(@garage)
    result = sendinblue_mailer.send_transactional_template(data)
    return (result['code'] == 'success')
  end

  def build_data_for_sendinblue_mailer(garage)
    to = garage.email
    bcc = EMAIL_ADMIN
    username = garage.name
    subject = t('Welcome to Ewoks')
    content = render partial: 'signup_link'
    data = { "id" => 4, "to" => to, "bcc"=> bcc, "attr" => {"USERNAME" => username, "SUBJECT" => subject, "CONTENT" => content} }
  end

  def send_confirmation_via_gmail
    mail(to: @garage.email, bcc: EMAIL_ADMIN, subject: t('Welcome to Ewoks'))
  end
end

