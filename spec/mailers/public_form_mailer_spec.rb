require 'spec_helper'

describe PublicFormMailer do
    describe 'garage after_create' do
    it 'should send an email to the owner' do
      garage = FactoryGirl.create(:garage)
      sent_email = PublicFormMailer.signup_confirmation(garage)
      sent_email.should deliver_from(EMAIL_ADMIN)
      sent_email.should deliver_to(garage.email)
      sent_email.should have_body_text(/Welcome to Ewoks/)
      sent_email.should have_body_text(/#{garage.signup_verification_token}/)
      sent_email.should have_subject( I18n.t('Welcome to Ewoks') )
    end
  end
end
