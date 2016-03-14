class HolidaysController < ApplicationController
  before_action :set_garage
  before_action :set_holiday, only: [:show, :edit, :update, :destroy]
  after_action :verify_authorized

  def index
    redirect_to user_path(current_user) unless policy(@garage).show?
    holidays = policy_scope(@garage.holidays.page(params[:page]))
    authorize holidays
    @holidays = HolidayDecorator.decorate_collection(holidays)
  end

  def show
    authorize @holiday
  end

  def new
    @holiday = @garage.holidays.build
    authorize @holiday
  end

  def edit
    authorize @holiday
  end

  def create
    @holiday = Holiday.create(holiday_params)
    authorize @holiday
    respond_to do |format|
      if @holiday.save
        format.html { redirect_to garage_holidays_url(@garage), notice: 'Holiday was successfully created.' }
      else
        format.html { render :new }
      end
    end
  end

  def update
    authorize @holiday
    respond_to do |format|
      if @holiday.update(holiday_params)
        format.html { redirect_to garage_holidays_url(@garage), notice: 'Holiday was successfully updated.' }
      else
        format.html { render :edit }
      end
    end
  end

  def destroy
    authorize @holiday
    @holiday.destroy
    respond_to do |format|
      format.html { redirect_to garage_holidays_url(@garage), notice: 'Holiday was successfully destroyed.' }
    end
  end

  private
    def set_holiday
      @holiday = @garage.holidays.find(params[:id])
    end

    def set_garage
      @garage = Garage.find(params[:garage_id])
    end

    def holiday_params
      params.require(:holiday).permit(:name, :start_date, :end_date, :garage_id)
    end
end
