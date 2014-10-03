require "spec_helper"

describe UserMailer do
  describe 'user after creating password' do
    it 'should send an email to the owner' do
      owner = FactoryGirl.create(:owner)
      sent_email = UserMailer.send_generated_password(owner)
      sent_email.should deliver_from(EMAIL_ADMIN)
      sent_email.should deliver_to(owner.email)
      sent_email.should have_subject( I18n.t('Your login for Ewoks') )
      # sent_email.should have_body_text(/Your account has been confirmed!/)
      sent_email.should have_body_text(/#{owner.email}/)
      sent_email.should have_body_text(/#{owner.password}/)
      sent_email.should have_body_text(/#{new_user_session_url}/)
    end
  end

  describe 'the country manager changes the status of a garage' do
   it 'should send an email to the owner' do
     garage = FactoryGirl.create(:garage)
     garage.create_my_owner
     owner = garage.user

     sent_email = UserMailer.send_changed_status_notification(owner)
     sent_email.should deliver_from(EMAIL_ADMIN)
     sent_email.should deliver_to(owner.email)
     sent_email.should have_subject( I18n.t('Your account has been changed') )
     sent_email.should have_body_text(/Your account has been activated!/)
     sent_email.should have_body_text(/#{owner.email}/)
     sent_email.should have_body_text(/#{owner.password}/)
     sent_email.should have_body_text(/#{new_user_session_url}/)
   end
 end
end
