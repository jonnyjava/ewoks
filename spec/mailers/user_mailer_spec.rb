require "spec_helper"

describe UserMailer do
  describe 'user after creating password' do
    it 'should send an email to the owner' do
      owner = FactoryGirl.create(:owner)
      sent_email = UserMailer.send_generated_password(owner)
      sent_email.should deliver_from(EMAIL_ADMIN)
      sent_email.should deliver_to(owner.email)
      sent_email.should have_subject( I18n.t('Your login for Ewoks') )
      sent_email.should have_body_text(/Your account has been confirmed!/)
      sent_email.should have_body_text(/#{owner.email}/)
      sent_email.should have_body_text(/#{owner.password}/)
      sent_email.should have_body_text(/#{new_user_session_url}/)
    end
  end
end
