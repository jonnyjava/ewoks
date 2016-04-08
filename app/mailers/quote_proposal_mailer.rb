class QuoteProposalMailer < ActionMailer::Base
  include MailerHelper

  default from: EMAIL_ADMIN

  def send_quote_to_contact(quote_proposal)
    @quote_proposal = quote_proposal
    @demand = quote_proposal.demand.decorate
    set_locale(@quote_proposal.garage)
    @subject = "#{t('go_to_the_quote')} #{@quote_proposal.identifier}"
    send_mail(@quote_proposal)
  end

  private

  def send_mail(quote_proposal)
    content = build_data_for_sendinblue_mailer(quote_proposal)
    SendinblueWrapper.new(content).send_via_sendiblue() || send_via_gmail
  end

  def build_data_for_sendinblue_mailer(quote_proposal)
    to = quote_proposal.demand.email
    bcc = EMAIL_ADMIN
    username = quote_proposal.demand.name_and_surnames
    subject = @subject
    data = { "id" => 5, "to" => to, "bcc"=> bcc, "attr" => {
        "USERNAME" => username,
        "SUBJECT" => subject,
        "QUOTE_TOKEN" => @quote_proposal.mail_token,
        "CITY" => @demand.city,
        "SERVICE_CATEGORY_NAME" => @demand.service_category_name,
        "SERVICE_NAME" => @demand.service_name
      }
    }
  end

  def send_via_gmail
    mail(to: @quote_proposal.demand.email, bcc: EMAIL_ADMIN, subject: @subject)
  end
end
