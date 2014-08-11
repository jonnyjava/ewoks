class PublicWizardController < ApplicationController
  skip_before_filter :authenticate_user!

  def public_wizard
    @garage = Garage.new(country: nil)
    render :public_wizard, layout: "public_form"
  end

  def create_garage
    @garage = Garage.new(garage_params)
    @garage.timetable = Timetable.new

    respond_to do |format|
      if @garage.save
        format.html { redirect_to create_timetable_url(@garage), notice: 'Garage was successfully created.' }
      else
        format.html { render :new }
      end
    end
  end

  private

  def garage_params
    params.require(:garage).permit(:name, :owner, :country, :street, :zip, :city, :email, :phone, :mobile, :fax, :latitude, :longitude, :tax_id, :website)
  end
end
