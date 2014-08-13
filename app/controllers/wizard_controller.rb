class WizardController < ApplicationController
  include PermittedParametersForPublicControllers
  layout 'public_form'
  before_action :set_garage, except: [:wizard, :create_garage]
  skip_before_filter :authenticate_user!

  def wizard
    @garage = Garage.new(country: nil)
    render :wizard
  end

  def create_garage
    @garage = Garage.new(garage_params)
    redirect_to_response(@garage, :wizard,  'timetable')
  end

  def timetable
    @timetable = Timetable.new(garage: @garage)
  end

  def create_timetable
    @timetable = Timetable.new(timetable_params)
    redirect_to_response(@garage, :timetable,  'holiday')
  end

  def holiday
    @holiday = Holiday.new(garage: @garage)
  end

  def create_holiday
    @holiday = Holiday.new(holiday_params)
    destination = params[:commit] == 'next' ? 'fee' : 'holiday'
    redirect_to_response(@garage, :holiday,  destination)
  end

  def fee
    @fee = Fee.new
    @tyre_fee = TyreFee.new
  end

  def create_fee
    @fee = Fee.new(fee_params)
    @tyre_fee = TyreFee.new(tyre_fee_params)
    @fee.garage = @garage
    @tyre_fee.fee = @fee

    redirect = wizard_fee_url(@garage)
    redirect = :success if params[:commit] == 'finish'

    respond_to do |format|
      if @fee.save && @tyre_fee.save
        format.html do
          redirect_to redirect, notice: notice_message('fee')
        end
      else
        format.html { render :create_fee }
      end
    end
  end

  private

  def redirect_to_response(object, origin, destination)
    respond_to do |format|
      if object.save
        format.html do
          destination = send("wizard_#{destination}_url".to_sym, object)
          redirect_to destination, notice: notice_message(object.class.name)
        end
      else
        format.html { render origin }
      end
    end
  end

  def set_garage
    @garage = Garage.find(params[:garage_id])
  end

  def notice_message(class_name)
    t('successfully created', class_name: t(class_name))
  end
end
