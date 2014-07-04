class TimetablesController < ApplicationController
  before_action :set_garage
  before_action :set_timetable, only: [:show, :edit, :update, :destroy]

  def index
    @timetables = @garage.timetables
  end

  def show
  end

  def new
    @timetable = @garage.timetables.build
  end

  def edit
  end

  def create
    @timetable = Timetable.new(timetable_params)

    respond_to do |format|
      if @timetable.save
        format.html { redirect_to edit_garage_timetable_url(@garage, @timetable), notice: "Timetable was successfully created." }
        format.json { render :show, status: :created, location: @timetable }
      else
        format.html { render :new }
        format.json { render json: @timetable.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    respond_to do |format|
      if @timetable.update(timetable_params)
        format.html { redirect_to edit_garage_timetable_url(@garage, @timetable), notice: "Timetable was successfully updated." }
        format.json { render :show, status: :ok, location: @timetable }
      else
        format.html { render :edit }
        format.json { render json: @timetable.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @timetable.destroy
    respond_to do |format|
      format.html { redirect_to edit_garage_timetable_url(@garage, @garage.timetable), notice: "Timetable was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private

  def set_garage
    @garage = Garage.find(params[:garage_id])
  end

  def set_timetable
    @timetable = Timetable.find(params[:id])
  end

  def timetable_params
    params.require(:timetable).permit(:mon_morning_open, :mon_morning_close, :mon_afternoon_open, :mon_afternoon_close, :tue_morning_open, :tue_morning_close, :tue_afternoon_open, :tue_afternoon_close, :wed_morning_open, :wed_morning_close, :wed_afternoon_open, :wed_afternoon_close, :thu_morning_open, :thu_morning_close, :thu_afternoon_open, :thu_afternoon_close, :fri_morning_open, :fri_morning_close, :fri_afternoon_open, :fri_afternoon_close, :sat_morning_open, :sat_morning_close, :sat_afternoon_open, :sat_afternoon_close, :sun_morning_open, :sun_morning_close, :sun_afternoon_open, :sun_afternoon_close, :garage_id)
  end
end
