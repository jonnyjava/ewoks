class PublicFormMailer < ActionMailer::Base
  include MailerHelper
  default from: EMAIL_ADMIN

  def signup_confirmation(garage)
    return if @@seeding
    @garage = garage
    @subject = t('Welcome')
    set_locale(garage)
    send_mail
  end

  private

  def send_mail
    content = build_data_for_sendinblue_mailer
    SendinblueWrapper.new(content).send_via_sendiblue || send_via_gmail
  end

  def build_data_for_sendinblue_mailer
    content = render partial: 'signup_link'
    { 'id' => 4,
      'to' => @garage.email,
      'bcc'=> EMAIL_ADMIN,
      'attr' => {
        'USERNAME' => @garage.name,
        'SUBJECT' => @subject,
        'CONTENT' => content
      }
    }
  end

  def send_via_gmail
    mail(to: @garage.email, bcc: EMAIL_ADMIN, subject: @subject)
  end
end

