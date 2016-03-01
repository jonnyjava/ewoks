class GarageRecruitablesController < ApplicationController
  before_action :set_garage_recruitable, only: [:show, :edit, :update, :destroy]
  after_action :verify_authorized

  def index
    @garage_recruitables = GarageRecruitable.all
    authorize @garage_recruitables
  end

  def show
    authorize @garage_recruitable
  end

  def new
    @garage_recruitable = GarageRecruitable.new
    authorize @garage_recruitable
  end

  def edit
    authorize @garage_recruitable
  end

  def create
    @garage_recruitable = GarageRecruitable.new(garage_recruitable_params)
    authorize @garage_recruitable
    respond_to do |format|
      if @garage_recruitable.save
        format.html { redirect_to @garage_recruitable, notice: 'Garage recruitable was successfully created.' }
        format.json { render :show, status: :created, location: @garage_recruitable }
      else
        format.html { render :new }
        format.json { render json: @garage_recruitable.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    authorize @garage_recruitable
    respond_to do |format|
      if @garage_recruitable.update(garage_recruitable_params)
        format.html { redirect_to @garage_recruitable, notice: 'Garage recruitable was successfully updated.' }
        format.json { render :show, status: :ok, location: @garage_recruitable }
      else
        format.html { render :edit }
        format.json { render json: @garage_recruitable.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    authorize @garage_recruitable
    @garage_recruitable.destroy
    respond_to do |format|
      format.html { redirect_to garage_recruitables_url, notice: 'Garage recruitable was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    def set_garage_recruitable
      @garage_recruitable = GarageRecruitable.find(params[:id])
    end

    def garage_recruitable_params
      params.require(:garage_recruitable).permit(:name, :street, :zip, :city, :email, :phone, :mobile, :tax_id, :province, :status)
    end
end
