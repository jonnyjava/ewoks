class PublicFormController < ApplicationController
  skip_before_filter :authenticate_user!

  def public_form
    @garage = Garage.new(country: nil)
    render :public_form, layout: false
  end

  def create_extra_holidays(rows)
    holidays = []
    (1..rows).each do |i|
      next unless params["holiday_#{i}".to_sym].present?
      holidays << Holiday.new(extra_holiday_params(i))
    end
    holidays
  end

  def validate_all(garage_properties)
    valid = true
    garage_properties.each do |property|
      valid = property.valid? && valid
    end
    valid
  end

  def assign_garage_to_his_related(garage, garage_properties)
    garage_properties.each do |property|
      property.garage = garage if property.respond_to?(:garage_id)
    end
  end

  def create
    rows = params[:holiday][:rows_counter].to_i

    @garage = Garage.new(garage_params)
    @garage.status = Garage::TO_BE_CONFIRMED
    @timetable = Timetable.new(timetable_params)
    @holiday = Holiday.new(holiday_params)
    @extra_holidays = create_extra_holidays(rows)
    @fee = Fee.new(fee_params)
    @tyre_fee = TyreFee.new(tyre_fee_params)

    garage_properties = []
    garage_properties <<  @holiday
    garage_properties <<  @extra_holidays if @extra_holidays.present?
    garage_properties <<  @timetable
    garage_properties <<  @fee
    garage_properties <<  @tyre_fee
    garage_properties = garage_properties.flatten

    valid_submission = @garage.valid? && validate_all(garage_properties)

    respond_to do |format|
      if !valid_submission
        format.html { render :public_form, layout: false }
      else
        if @garage.save
          assign_garage_to_his_related(@garage, garage_properties)
          @tyre_fee.fee = @fee
          if garage_properties.each(&:save)
            format.html { redirect_to :success, notice: 'Garage was successfully created.'}
          else
            format.html { render :public_form, layout: false }
          end
        else
          format.html { render :public_form, layout: false }
        end
      end
    end
  end

  def success
    render :success, layout: false
  end

  private

  def garage_params
    params.require(:garage).permit(:name, :owner, :country, :street, :zip, :city, :email, :phone, :mobile, :fax, :latitude, :longitude, :tax_id, :website)
  end

  def timetable_params
    params.require(:timetable).permit(:mon_morning_open, :mon_morning_close, :mon_afternoon_open, :mon_afternoon_close, :tue_morning_open, :tue_morning_close, :tue_afternoon_open, :tue_afternoon_close, :wed_morning_open, :wed_morning_close, :wed_afternoon_open, :wed_afternoon_close, :thu_morning_open, :thu_morning_close, :thu_afternoon_open, :thu_afternoon_close, :fri_morning_open, :fri_morning_close, :fri_afternoon_open, :fri_afternoon_close, :sat_morning_open, :sat_morning_close, :sat_afternoon_open, :sat_afternoon_close, :sun_morning_open, :sun_morning_close, :sun_afternoon_open, :sun_afternoon_close, :garage_id)
  end

  def holiday_params
    params.require(:holiday).permit(:name, :start_date, :end_date)
  end

  def extra_holiday_params(i)
    params.require("holiday_#{i}".to_sym).permit(:name, :start_date, :end_date)
  end

  def tyre_fee_params
    params.require(:tyre_fee).permit(:vehicle_type, :diameter_min, :diameter_max, :rim_type)
  end

  def fee_params
    params.require(:fee).permit(:name, :price)
  end
end
