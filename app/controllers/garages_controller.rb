class GaragesController < ApplicationController
  before_action :set_garage, only: [:show, :edit, :update, :destroy, :toggle_status, :destroy_logo]
  skip_before_filter :authenticate_user!, only: :signup_verification
  after_action :verify_authorized, except: :signup_verification

  def index
    garages = policy_scope(Garage.all.order(:name).page(params[:page]))
    authorize garages
    @garages = GarageDecorator.decorate_collection(garages)
  end

  def show
    authorize @garage
    @tyre_fees = @garage.tyre_fees.all
  end

  def new
    country = current_user.country_manager? ? current_user.country : nil
    @garage = Garage.new(country: country)
    authorize @garage
  end

  def edit
    authorize @garage
  end

  def create
    @garage = Garage.new(garage_params)
    @garage.country = current_user.try(:country)
    @garage.timetable = Timetable.new
    authorize @garage
    respond_to do |format|
      if @garage.save
        format.html { redirect_to @garage, notice: 'Garage was successfully created.' }
      else
        format.html { render :new }
      end
    end
  end

  def update
    authorize @garage
    respond_to do |format|
      if @garage.update(garage_params)
        format.html { redirect_to @garage, notice: 'Garage was successfully updated.' }
      else
        format.html { render :edit }
      end
    end
  end

  def destroy
    authorize @garage
    @garage.destroy
    respond_to do |format|
      format.html { redirect_to garages_url, notice: 'Garage was successfully destroyed.' }
    end
  end

  def destroy_logo
    authorize @garage
    @garage.logo.destroy
    @garage.save

    respond_to do |format|
      format.html { redirect_to garage_url @garage }
    end
  end

  def toggle_status
    authorize @garage
    @garage.active? ? @garage.inactive! : @garage.active! unless @garage.to_be_confirmed?

    respond_to do |format|
      format.html { redirect_to garages_url }
    end
  end

  def signup_verification
    if @garage = Garage.find_by_signup_verification_token(params[:token])
      @garage.inactive!
      @garage.create_my_owner
      render :welcome_page, layout: "devise"
    else
      redirect_to error_404_path
    end
  end

  private
    def set_garage
      @garage = Garage.find(params[:id])
    end

    def garage_params
      params.require(:garage).permit(:name, :owner, :country, :street, :zip, :province, :city, :email, :phone, :mobile, :fax, :latitude, :longitude, :tax_id, :website, :logo, :status)
    end
end
