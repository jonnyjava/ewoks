class WizardController < ApplicationController
  include PermittedParametersForPublicControllers

  layout 'public_form'
  before_action :set_garage, except: [:wizard, :create_garage]
  skip_before_filter :authenticate_user!
  after_filter :allow_iframe

  def allow_iframe
    response.headers.delete "X-Frame-Options"
  end

  def wizard
    @garage = Garage.new(country: nil)
    render :wizard
  end

  def create_garage
    @garage = Garage.new(garage_params)
    @garage.country = fetch_country_from_locale(I18n.locale)
    @garage.timetable = Timetable.new
    redirect_to_response(@garage, :wizard, 'timetable')
  end

  def timetable
    @timetable = @garage.timetable
  end

  def update_timetable
    @timetable = @garage.timetable
    respond_to do |format|
      if @timetable.update(timetable_params)
        format.html { redirect_to wizard_holiday_url(@garage, locale: I18n.locale), notice: notice_message("Timetable") }
      else
        format.html { render :timetable }
      end
    end
  end

  def holiday
    @holidays = @garage.holidays
    @holiday = Holiday.new(garage: @garage)
  end

  def create_holiday
    @holiday = Holiday.new(holiday_params)
    destination = params[:commit] == 'next' ? 'fee' : 'holiday'
    redirect_to_response(@holiday, :holiday,  destination)
  end

  def fee
    @tyre_fees = @garage.tyre_fees
    @tyre_fee = TyreFee.new(garage: @garage)
  end

  def create_fee
    @tyre_fee = TyreFee.new(tyre_fee_params)
    destination = params[:commit] == 'finish' ? success_url(locale: I18n.locale) : 'fee'
    redirect_to_response(@tyre_fee, :fee,  destination)
  end

  private

  def redirect_to_response(object, origin, destination)
    respond_to do |format|
      if object.save
        format.html do
          destination = send("wizard_#{destination}_url".to_sym, @garage, locale: I18n.locale) unless destination == success_url(locale: I18n.locale)
          redirect_to destination, notice: notice_message(object.class.name)
        end
      else
        format.html { render origin }
      end
    end
  end

  def set_garage
    @garage = Garage.find(secure_garage_id)
  end

  def secure_garage_id
    params[:garage_id].to_i
  end

  def notice_message(class_name)
    t('successfully created', class_name: t(class_name))
  end
end
