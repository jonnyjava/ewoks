require "spec_helper"

describe UserMailer do
   before(:each) do
     garage = FactoryGirl.create(:garage)
     garage.create_my_owner
     @owner = garage.user
   end

  describe 'user after creating password' do
    it 'should send an email to the owner' do
      sent_email = UserMailer.send_generated_password(@owner)
      expect(sent_email).to deliver_from(EMAIL_ADMIN)
      expect(sent_email).to deliver_to(@owner.email)
      expect(sent_email).to have_subject( I18n.t('Your login for Ewoks') )
      expect(sent_email).to have_body_text(I18n.t('Your account has been confirmed!'))
      expect(sent_email).to have_body_text(/#{@owner.email}/)
      expect(sent_email).to have_body_text(/#{@owner.password}/)
      expect(sent_email).to have_body_text(/#{new_user_session_url}/)
    end
  end

  describe 'the country manager changes the status of a garage' do
   it 'should send an email to the owner' do
     sent_email = UserMailer.send_changed_status_notification(@owner)
     expect(sent_email).to deliver_from(EMAIL_ADMIN)
     expect(sent_email).to deliver_to(@owner.email)
     expect(sent_email).to have_subject( I18n.t('Your account has been changed'))
     expect(sent_email).to have_body_text(I18n.t('Your account has been activated'))
     expect(sent_email).to have_body_text(/#{new_user_session_url}/)
   end
 end
end
