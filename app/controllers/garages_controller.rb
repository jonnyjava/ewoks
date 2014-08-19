class GaragesController < ApplicationController
  before_action :set_garage, only: [:show, :edit, :update, :destroy, :toggle_status, :destroy_logo]
  skip_before_filter :authenticate_user!, only: :signup_verification
  after_action :verify_authorized, except: :signup_verification

  # GET /garages
  # GET /garages.json
  def index
    garages = policy_scope(Garage.all.order(:name).page(params[:page]))
    authorize garages
    @garages = GarageDecorator.decorate_collection(garages)
  end

  # GET /garages/1
  # GET /garages/1.json
  def show
    authorize @garage
    @tyre_fees = @garage.tyre_fees.all
  end

  # GET /garages/new
  def new
    country = current_user.country_manager? ? current_user.country : nil
    @garage = Garage.new(country: country)
    authorize @garage
  end

  # GET /garages/1/edit
  def edit
    authorize @garage
  end

  # POST /garages
  # POST /garages.json
  def create
    @garage = Garage.new(garage_params)
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

  # PATCH/PUT /garages/1
  # PATCH/PUT /garages/1.json
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

  # DELETE /garages/1
  # DELETE /garages/1.json
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
    # Use callbacks to share common setup or constraints between actions.
    def set_garage
      @garage = Garage.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def garage_params
      params.require(:garage).permit(:name, :owner, :country, :street, :zip, :city, :email, :phone, :mobile, :fax, :latitude, :longitude, :tax_id, :website, :logo, :status)
    end
end
