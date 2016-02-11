require 'spec_helper'

describe PublicFormMailer do
    describe 'garage after_create' do
    it 'should send an email to the owner' do
      garage = FactoryGirl.create(:garage)
      sent_email = PublicFormMailer.signup_confirmation(garage)
      expect(sent_email).to deliver_from(EMAIL_ADMIN)
      expect(sent_email).to deliver_to(garage.email)
      expect(sent_email).to have_body_text(I18n.t('Welcome to Ewoks'))
      expect(sent_email).to have_body_text(/#{garage.signup_verification_token}/)
      expect(sent_email).to have_subject(I18n.t('Welcome to Ewoks'))
    end
  end
end
