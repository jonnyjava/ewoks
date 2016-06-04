class QuoteProposalMailer < ActionMailer::Base
  include MailerHelper

  default from: EMAIL_ADMIN

  def send_quote_to_contact(quote_proposal)
    return if @@seeding
    @quote_proposal = quote_proposal
    @demand = quote_proposal.demand.decorate
    set_locale(@quote_proposal.garage)
    @subject = "#{t('go_to_the_quote')} #{@quote_proposal.identifier}"
    send_mail
  end

  private

  def send_mail
    content = build_data_for_sendinblue_mailer
    SendinblueWrapper.new(content).send_via_sendiblue || send_via_gmail
  end

  def build_data_for_sendinblue_mailer
    { 'id' => 5,
      'to' => @quote_proposal.demand.email,
      'bcc'=> EMAIL_ADMIN,
      'attr' => {
        'USERNAME' => @quote_proposal.demand.name_and_surnames,
        'SUBJECT' => @subject,
        'QUOTE_TOKEN' => @quote_proposal.mail_token,
        'CITY' => @demand.city,
        'SERVICE_CATEGORY_NAME' => @demand.service_category_name,
        'SERVICE_NAME' => @demand.service_name
      }
    }
  end

  def send_via_gmail
    mail(to: @quote_proposal.demand.email, bcc: EMAIL_ADMIN, subject: @subject)
  end
end
