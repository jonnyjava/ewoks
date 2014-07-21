require 'spec_helper'

describe PublicFormMailer do
    describe 'garage after_create' do
    it 'should send an email to the owner' do
      email = 'obi@kenobi.one'
      sent_email = PublicFormMailer.sing_up_confirmation(email)
      sent_email.should deliver_from(EMAIL_ADMIN)
      sent_email.should deliver_to(email)
      sent_email.should have_body_text(/Welcome to EWOKS!/)
      sent_email.should have_subject('Welcome to Ewoks')
    end
  end
end
