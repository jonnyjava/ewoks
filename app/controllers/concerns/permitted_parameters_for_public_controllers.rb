module PermittedParametersForPublicControllers
  include PermittedParametersForTimetable
  extend ActiveSupport::Concern

  def garage_params
    params.require(:garage).permit(:name, :owner, :country, :street, :zip, :province, :city, :email, :phone, :mobile, :fax, :latitude, :longitude, :tax_id, :website)
  end

  def holiday_params
    params.require(:holiday).permit(:garage_id, :name, :start_date, :end_date)
  end

  def tyre_fee_params
    params.require(:tyre_fee).permit(:garage_id, :name, :price, :vehicle_type, :diameter_min, :diameter_max, :rim_type)
  end
end
