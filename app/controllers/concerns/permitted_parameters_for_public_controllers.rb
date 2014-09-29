module PermittedParametersForPublicControllers
  extend ActiveSupport::Concern

  def garage_params
    params.require(:garage).permit(:name, :owner, :country, :street, :zip, :town, :city, :email, :phone, :mobile, :fax, :latitude, :longitude, :tax_id, :website)
  end

  def timetable_params
    params.require(:timetable).permit(:garage_id, :mon_morning_open, :mon_morning_close, :mon_afternoon_open, :mon_afternoon_close, :tue_morning_open, :tue_morning_close, :tue_afternoon_open, :tue_afternoon_close, :wed_morning_open, :wed_morning_close, :wed_afternoon_open, :wed_afternoon_close, :thu_morning_open, :thu_morning_close, :thu_afternoon_open, :thu_afternoon_close, :fri_morning_open, :fri_morning_close, :fri_afternoon_open, :fri_afternoon_close, :sat_morning_open, :sat_morning_close, :sat_afternoon_open, :sat_afternoon_close, :sun_morning_open, :sun_morning_close, :sun_afternoon_open, :sun_afternoon_close)
  end

  def holiday_params
    params.require(:holiday).permit(:garage_id, :name, :start_date, :end_date)
  end

  def tyre_fee_params
    params.require(:tyre_fee).permit(:garage_id, :name, :price, :vehicle_type, :diameter_min, :diameter_max, :rim_type)
  end
end
