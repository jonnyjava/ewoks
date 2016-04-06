class PublicFormMailer < ActionMailer::Base
  include MailerHelper
  default from: EMAIL_ADMIN

  def signup_confirmation(garage)
    @garage = garage
    set_locale(garage)
    send_mail(@garage)
  end

  private

  def send_mail(garage)
    content = build_data_for_sendinblue_mailer(garage)
    SendinblueWrapper.new(content).send_via_sendiblue() || send_via_gmail
  end

  def build_data_for_sendinblue_mailer(garage)
    to = garage.email
    bcc = EMAIL_ADMIN
    username = garage.name
    subject = t('Welcome')
    content = render partial: 'signup_link'
    data = { "id" => 4, "to" => to, "bcc"=> bcc, "attr" => {"USERNAME" => username, "SUBJECT" => subject, "CONTENT" => content} }
  end

  def send_via_gmail
    mail(to: @garage.email, bcc: EMAIL_ADMIN, subject: t('Welcome'))
  end
end

