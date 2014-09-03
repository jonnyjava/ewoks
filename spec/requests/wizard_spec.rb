require 'spec_helper'

describe 'Wizard' do
  login_user
  let(:garage) { FactoryGirl.create(:garage_with_timetable) }

  describe 'GET /wizard' do
    it 'should return status success' do
      get wizard_url
      response.status.should be(200)
    end
  end

  describe 'POST /wizard_create_garage' do
    it 'should return status 302 and redirect to timetable' do
      posted_params = FactoryGirl.attributes_for(:garage)
      post wizard_create_garage_url(garage: posted_params)
      response.status.should be(302)
      new_garage = assigns[:garage]
      response.should redirect_to wizard_timetable_url(new_garage)
    end
  end

  describe 'GET /wizard_timetable' do
    it 'should return status success' do
      get wizard_timetable_url(garage)
      response.status.should be(200)
    end
  end

  describe 'POST /wizard_create_timetable' do
    it 'should return status 302 and redirect to holiday' do
      posted_params = FactoryGirl.attributes_for(:timetable)
      patch wizard_update_timetable_url(garage, timetable: posted_params)
      response.status.should be(302)
      response.should redirect_to wizard_holiday_url(garage)
    end
  end

  describe 'GET /wizard_holiday' do
    it 'should return status success' do
      get wizard_holiday_url(garage)
      response.status.should be(200)
    end
  end

  describe 'POST /wizard_create_timetable' do
    let(:posted_params) { FactoryGirl.attributes_for(:holiday) }

    context 'submitting to create another holiday after this one' do
      it 'should return status 302 and redirect to holiday' do
        post wizard_create_holiday_url(garage, holiday: posted_params)
        response.status.should be(302)
        response.should redirect_to wizard_holiday_url(garage)
      end
    end

    context 'submitting to next step' do
      it 'should return status 302 and redirect to fee' do
        post wizard_create_holiday_url(garage, holiday: posted_params, commit: 'next')
        response.status.should be(302)
        response.should redirect_to wizard_fee_url(garage)
      end
    end
  end

  describe 'GET /wizard_fee' do
    it 'should return status success' do
      get wizard_fee_url(garage)
      response.status.should be(200)
    end
  end

  describe 'POST /wizard_create_fee' do
    let(:posted_params) { FactoryGirl.attributes_for(:tyre_fee) }

    context 'submitting to create another fee after this one' do
      it 'should return status 302 and redirect to fee' do
        post wizard_create_fee_url(garage, tyre_fee: posted_params)
        response.status.should be(302)
        response.should redirect_to wizard_fee_url(garage)
      end
    end

    context 'submitting to next step' do
      it 'should return status 302 and redirect to success' do
        post wizard_create_fee_url(garage, tyre_fee: posted_params, commit: 'finish')
        response.status.should be(302)
        response.should redirect_to success_url
      end
    end
  end
end
