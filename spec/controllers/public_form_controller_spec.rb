require 'spec_helper'

describe PublicFormController do

  describe 'GET public_form' do
    it 'returns http success' do
      get 'public_form'
      response.should be_success
    end
  end

  describe 'POST' do
    let(:valid_session) { {} }
    let(:garage) { FactoryGirl.build(:garage) }
    locales = COUNTRIES_WITH_LOCALE.keys

    context 'with valid params' do

      let(:garage_params) { FactoryGirl.attributes_for(:garage, garage: garage) }
      let(:tyre_fee_params) { FactoryGirl.attributes_for(:tyre_fee, garage: garage) }
      let(:holiday_params) { FactoryGirl.attributes_for(:holiday, garage: garage) }
      let(:timetable_params) { FactoryGirl.attributes_for(:timetable, garage: garage) }
      let(:valid_params) { { locale: locales.sample.to_sym, garage: garage_params, tyre_fee: tyre_fee_params, holiday: holiday_params, timetable: timetable_params } }

      it 'creates a new Garage' do
        n = Garage.count
        post :create, valid_params, valid_session
        response.should redirect_to success_path
        Garage.count.should be(n+1)
      end
    end

    context 'with invalid params' do
      let(:garage_params) { { 'wrong_param' => 'wrong' } }
      let(:tyre_fee_params) { { 'wrong_param' => 'wrong' } }
      let(:holiday_params) { { 'wrong_param' => 'wrong' } }
      let(:timetable_params) { { 'wrong_param' => 'wrong' } }

      let(:invalid_params) { { locale: locales.sample, garage: garage_params, tyre_fee: tyre_fee_params, holiday: holiday_params, timetable: timetable_params } }

      it 'should re-render the form' do
        n = Garage.count
        post :create, invalid_params, valid_session
        response.should render_template 'public_form'
        Garage.count.should be(n)
      end
    end
  end
end
