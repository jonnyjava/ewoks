class GarageMailer < ActionMailer::Base
  include MailerHelper
  default from: EMAIL_ADMIN

  def notify_demand(garage, demand)
    return if @@seeding
    @user = garage.user
    @demand = demand
    set_locale(garage)
    @subject = t('new_demand_assigned_to_you')
    send_mail
  end

  private

  def send_mail
    content = build_data_for_sendinblue_mailer
    SendinblueWrapper.new(content).send_via_sendiblue || send_via_gmail
  end

  def build_data_for_sendinblue_mailer
    content = render partial: 'link_to_demand', locals:  {user: @user, demand: @demand }
    { 'id' => 6,
      'to' => @user.email,
      'bcc'=> EMAIL_ADMIN,
      'attr' => {
        'USERNAME' => @user.decorate.complete_name,
        'SUBJECT' => @subject,
        'CONTENT' => content
      }
    }
  end

  def send_via_gmail
    mail(to: @user.email, bcc: EMAIL_ADMIN, subject: @subject)
  end
end
