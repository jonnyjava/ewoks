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
    respond_to do |format|
      if @garage.save
        format.html do
          redirect_to wizard_timetable_url(@garage), notice: notice_message('garage')
        end
      else
        format.html { render :wizard }
      end
    end
  end

  def timetable
    @timetable = Timetable.new(garage: @garage)
  end

  def create_timetable
    @timetable = Timetable.new(timetable_params)

    respond_to do |format|
      if @timetable.save
        format.html do
          redirect_to wizard_holiday_url(@garage), notice: notice_message('timetable')
        end
      else
        format.html { render :timetable }
      end
    end
  end

  def holiday
    @holiday = Holiday.new(garage: @garage)
  end

  def create_holiday
    @holiday = Holiday.new(holiday_params)

    respond_to do |format|
      if @holiday.save
        redirect = params[:commit] == 'next' ? wizard_fee_url(@garage) : wizard_holiday_url(@garage)
        format.html do
          redirect_to redirect, notice: notice_message('holiday')
        end
      else
        format.html { render :holiday }
      end
    end
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
    respond_to do |format|
      if @fee.save
        if @tyre_fee.save
          redirect = params[:commit] == 'finish' ? :success : wizard_fee_url(@garage)
          format.html do
            redirect_to redirect, notice: notice_message('fee')
          end
        else
          format.html { render :create_fee }
        end
      else
        format.html { render :create_fee }
      end
    end
  end

  private

  def set_garage
    @garage = Garage.find(params[:garage_id])
  end

  def notice_message(class_name)
    t('successfully created', class_name: t(class_name))
  end
end
