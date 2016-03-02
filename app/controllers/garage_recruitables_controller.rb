class GarageRecruitablesController < ApplicationController
  before_action :set_garage_recruitable, only: [:show, :edit, :update, :destroy]
  after_action :verify_authorized

  def index
    garage_recruitables = GarageRecruitable.all.order(:name).page(params[:page])
    garage_recruitables = filter(garage_recruitables, garage_recruitable_params) if params[:garage_recruitable]
    authorize garage_recruitables
    @garage_recruitables = GarageRecruitableDecorator.decorate_collection(garage_recruitables)
  end

  def show
    authorize @garage_recruitable
  end

  def edit
    authorize @garage_recruitable
  end

  def export
    garage_recruitables = GarageRecruitable.where(id: params[:ids])
    authorize_collection garage_recruitables
    @garage_recruitables = garage_recruitables
    respond_to :xls
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

    def filter(collection, filtering_params)
      filtering_params.each { |name, value| collection = collection.send('filter_by', name, value ) }
      collection.by_status(filtering_params[:status])
    end

    def authorize_collection(authorizable_collection)
      return authorize authorizable_collection if authorizable_collection.blank?
      authorizable_collection.each { |element| authorize element }
    end

    def set_garage_recruitable
      @garage_recruitable = GarageRecruitable.find(params[:id]).decorate
    end

    def garage_recruitable_params
      params.require(:garage_recruitable).permit(:name, :street, :zip, :city, :email, :phone, :mobile, :tax_id, :province, :status)
    end
end
