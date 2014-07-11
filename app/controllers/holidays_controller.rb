class HolidaysController < ApplicationController
  before_action :set_garage
  before_action :set_holiday, only: [:show, :edit, :update, :destroy]
  after_action :verify_authorized

  # GET /holidays
  # GET /holidays.json
  def index
    holidays = @garage.holidays.page(params[:page])
    authorize holidays
    @holidays = HolidayDecorator.decorate_collection(holidays)
  end

  # GET /holidays/1
  # GET /holidays/1.json
  def show
    authorize @holiday
  end

  # GET /holidays/new
  def new
    @holiday = @garage.holidays.build
    authorize @holiday
  end

  # GET /holidays/1/edit
  def edit
    authorize @holiday
  end

  # POST /holidays
  # POST /holidays.json
  def create
    @holiday = Holiday.create(holiday_params)
    authorize @holiday
    respond_to do |format|
      if @holiday.save
        format.html { redirect_to garage_holidays_url(@garage), notice: 'Holiday was successfully created.' }
        format.json { render :show, status: :created, location: @holiday }
      else
        format.html { render :new }
        format.json { render json: @holiday.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /holidays/1
  # PATCH/PUT /holidays/1.json
  def update
    authorize @holiday
    respond_to do |format|
      if @holiday.update(holiday_params)
        format.html { redirect_to garage_holidays_url(@garage), notice: 'Holiday was successfully updated.' }
        format.json { render :show, status: :ok, location: @holiday }
      else
        format.html { render :edit }
        format.json { render json: @holiday.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /holidays/1
  # DELETE /holidays/1.json
  def destroy
    authorize @holiday
    @holiday.destroy
    respond_to do |format|
      format.html { redirect_to garage_holidays_url(@garage), notice: 'Holiday was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_holiday
      @holiday = @garage.holidays.find(params[:id])
    end

    def set_garage
      @garage = Garage.find(params[:garage_id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def holiday_params
      params.require(:holiday).permit(:name, :start_date, :end_date, :garage_id)
    end
end
