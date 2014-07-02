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
        format.html { redirect_to garage_timetables_url(@garage), notice: 'Timetable was successfully created.' }
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
        format.html { redirect_to garage_timetables_url(@garage), notice: 'Timetable was successfully updated.' }
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
      format.html { redirect_to garage_timetables_url(@garage), notice: 'Timetable was successfully destroyed.' }
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
      params.require(:timetable).permit(:day, :morning_opening, :morning_closing, :afternoon_opening, :afternoon_closing, :garage_id)
    end
end
