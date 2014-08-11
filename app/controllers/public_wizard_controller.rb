class PublicWizardController < ApplicationController
  include PermittedParametersForPublicControllers
  layout 'public_form'
  before_action :set_garage, except: [:public_wizard, :create_garage]
  skip_before_filter :authenticate_user!

  def public_wizard
    @garage = Garage.new(country: nil)
    render :public_wizard
  end

  def create_garage
    @garage = Garage.new(garage_params)
    respond_to do |format|
      if @garage.save
        format.html { redirect_to public_wizard_show_timetable_url(@garage), notice: 'Garage was successfully created.' }
      else
        format.html { render :public_wizard }
      end
    end
  end

  def show_timetable
    @timetable = Timetable.new(garage: @garage)
  end

  def create_timetable
    @timetable = Timetable.new(timetable_params)

    respond_to do |format|
      if @timetable.save
        format.html { redirect_to public_wizard_show_holiday_url(@garage), notice: "Timetable was successfully created." }
      else
        format.html { render :show_timetable }
      end
    end
  end

  def show_holiday
    @holiday = Holiday.new(garage: @garage)
  end

  def create_holiday
    @holiday = Holiday.new(holiday_params)

    respond_to do |format|
      if @holiday.save
        redirect = params[:commit] == 'next' ? public_wizard_show_fee_url(@garage) : public_wizard_show_holiday_url(@garage)
        format.html { redirect_to redirect, notice: "Holiday was successfully created." }
      else
        format.html { render :show_holiday }
      end
    end
  end

  def show_fee
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
          redirect = params[:commit] == 'finish' ? :success : public_wizard_show_fee_url(@garage)
          format.html { redirect_to redirect, notice: "Tyre fee was successfully created." }
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
end
