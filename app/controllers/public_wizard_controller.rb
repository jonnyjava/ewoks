class PublicWizardController < ApplicationController
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

  private

  def set_garage
    @garage = Garage.find(params[:garage_id])
  end

  def garage_params
    params.require(:garage).permit(:name, :owner, :country, :street, :zip, :city, :email, :phone, :mobile, :fax, :latitude, :longitude, :tax_id, :website)
  end

  def timetable_params
    params.require(:timetable).permit(:mon_morning_open, :mon_morning_close, :mon_afternoon_open, :mon_afternoon_close, :tue_morning_open, :tue_morning_close, :tue_afternoon_open, :tue_afternoon_close, :wed_morning_open, :wed_morning_close, :wed_afternoon_open, :wed_afternoon_close, :thu_morning_open, :thu_morning_close, :thu_afternoon_open, :thu_afternoon_close, :fri_morning_open, :fri_morning_close, :fri_afternoon_open, :fri_afternoon_close, :sat_morning_open, :sat_morning_close, :sat_afternoon_open, :sat_afternoon_close, :sun_morning_open, :sun_morning_close, :sun_afternoon_open, :sun_afternoon_close, :garage_id)
  end
end
