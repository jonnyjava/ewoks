class GaragePropertiesController < ApplicationController
  before_action :set_garage_property, only: [:show, :edit, :update, :destroy]

  # GET /garage_properties
  # GET /garage_properties.json
  def index
    @garage_properties = GarageProperty.all
  end

  # GET /garage_properties/1
  # GET /garage_properties/1.json
  def show
  end

  # GET /garage_properties/new
  def new
    @garage_property = GarageProperty.new
  end

  # GET /garage_properties/1/edit
  def edit
  end

  # POST /garage_properties
  # POST /garage_properties.json
  def create
    @garage_property = GarageProperty.new(garage_property_params)

    respond_to do |format|
      if @garage_property.save
        format.html { redirect_to @garage_property, notice: 'Garage property was successfully created.' }
        format.json { render :show, status: :created, location: @garage_property }
      else
        format.html { render :new }
        format.json { render json: @garage_property.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /garage_properties/1
  # PATCH/PUT /garage_properties/1.json
  def update
    respond_to do |format|
      if @garage_property.update(garage_property_params)
        format.html { redirect_to @garage_property, notice: 'Garage property was successfully updated.' }
        format.json { render :show, status: :ok, location: @garage_property }
      else
        format.html { render :edit }
        format.json { render json: @garage_property.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /garage_properties/1
  # DELETE /garage_properties/1.json
  def destroy
    @garage_property.destroy
    respond_to do |format|
      format.html { redirect_to garage_properties_url, notice: 'Garage property was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_garage_property
      @garage_property = GarageProperty.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def garage_property_params
      params.require(:garage_property).permit(:value, :garage_id, :property_id)
    end
end
