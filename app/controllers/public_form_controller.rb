class PublicFormController < ApplicationController
  include PermittedParametersForPublicControllers

  skip_before_filter :authenticate_user!

  def public_form
    @garage = Garage.new(country: nil)
    render :public_form
  end

  def create
    holiday_rows = params[:holiday][:rows_counter].to_i
    tyre_fee_rows = params[:tyre_fee][:rows_counter].to_i

    @garage = Garage.new(garage_params)
    @garage.country = fetch_country_from_locale(I18n.locale)
    @garage.status = 'to_confirm'
    @timetable = Timetable.new(timetable_params)
    @holiday = Holiday.new(holiday_params)
    @extra_holidays = create_extra_holidays(holiday_rows)
    @tyre_fee = TyreFee.new(tyre_fee_params)
    @extra_tyre_fees = create_extra_tyre_fees(tyre_fee_rows)
    garage_properties = []
    garage_properties <<  @holiday
    garage_properties <<  @extra_holidays if @extra_holidays.present?
    garage_properties <<  @timetable
    garage_properties <<  @tyre_fee
    garage_properties <<  @extra_tyre_fees if @extra_tyre_fees.present?
    garage_properties = garage_properties.flatten

    valid_submission = @garage.valid? && validate_all(garage_properties)
    respond_to do |format|
      if !valid_submission
        format.html { render :public_form }
      else
        if @garage.save
          assign_garage_to_his_related(@garage, garage_properties)
          if garage_properties.each(&:save)
            format.html { redirect_to :success }
          else
            format.html { render :public_form }
          end
        else
          format.html { render :public_form }
        end
      end
    end
  end

  def success
    render :success, layout: false
  end

  private

  def create_extra_holidays(rows)
    holidays = []
    (1..rows).each do |i|
      next unless params["holiday_#{i}".to_sym].present?
      holidays << Holiday.new(extra_holiday_params(i))
    end
    holidays
  end

  def create_extra_tyre_fees(rows)
    tyre_fees = []
    (1..rows).each do |i|
      next unless params["tyre_fee_#{i}".to_sym].present?
      tyre_fees << TyreFee.new(extra_tyre_fee_params(i))
    end
    tyre_fees
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

  def extra_holiday_params(i)
    params.require("holiday_#{i}".to_sym).permit(:name, :start_date, :end_date)
  end

  def extra_tyre_fee_params(i)
    params.require("tyre_fee_#{i}".to_sym).permit(:name, :price, :vehicle_type, :diameter_min, :diameter_max, :rim_type)
  end

end
