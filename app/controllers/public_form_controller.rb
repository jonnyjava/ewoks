class PublicFormController < ApplicationController
  skip_before_filter :authenticate_user!

  def public_form
    @garage = Garage.new(country: nil)
    @timetable = Timetable.new
    @holiday = Holiday.new
    @fee = Fee.new
    @tyre_fee = TyreFee.new
    render :public_form, layout: false
  end

  def create
    @garage = Garage.new(garage_params)
    @garage.status = Garage::INACTIVE
    @garage.timetable = Timetable.new(timetable_params)
    @holiday = Holiday.create(holiday_params)
    @fee = Fee.new(fee_params)
    @tyre_fee = TyreFee.new(tyre_fee_params)

    respond_to do |format|
      if @garage.save

        @holiday.garage = @garage
        @fee.garage = @garage
        @tyre_fee.fee = @fee

        @garage.timetable.save
        @holiday.save
        @fee.save
        @tyre_fee.save
        format.html { redirect_to :success, notice: 'Garage was successfully created.'}
      else
        format.html { render :public_form, layout: false }
      end
    end
  end

  def success
    render :success, layout: false
  end

  private
    # Never trust parameters from the scary internet, only allow the white list through.
    def garage_params
      params.require(:garage).permit(:name, :owner, :country, :street, :zip, :city, :email, :phone, :mobile, :fax, :latitude, :longitude, :tax_id, :website)
    end

    def timetable_params
      params.require(:timetable).permit(:mon_morning_open, :mon_morning_close, :mon_afternoon_open, :mon_afternoon_close, :tue_morning_open, :tue_morning_close, :tue_afternoon_open, :tue_afternoon_close, :wed_morning_open, :wed_morning_close, :wed_afternoon_open, :wed_afternoon_close, :thu_morning_open, :thu_morning_close, :thu_afternoon_open, :thu_afternoon_close, :fri_morning_open, :fri_morning_close, :fri_afternoon_open, :fri_afternoon_close, :sat_morning_open, :sat_morning_close, :sat_afternoon_open, :sat_afternoon_close, :sun_morning_open, :sun_morning_close, :sun_afternoon_open, :sun_afternoon_close, :garage_id)
    end

    def holiday_params
      params.require(:holiday).permit(:name, :start_date, :end_date, :garage_id)
    end
    def tyre_fee_params
      params.require(:tyre_fee).permit(:vehicle_type, :diameter_min, :diameter_max, :rim_type)
    end

    def fee_params
      params.require(:fee).permit(:name, :price)
    end
end
