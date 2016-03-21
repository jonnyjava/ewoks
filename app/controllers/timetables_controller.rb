class TimetablesController < ApplicationController
  include PermittedParametersForTimetable

  before_action :set_garage
  before_action :set_timetable, only: [:show, :edit, :update, :destroy]
  after_action :verify_authorized

  def index
    @timetables = @garage.timetables
  end

  def show
  end

  def new
    @timetable = @garage.timetables.build
    authorize @timetable
  end

  def edit
    redirect_to user_path(current_user) unless policy(@garage).show?
    authorize @timetable
  end

  def create
    @timetable = Timetable.new(timetable_params)
    authorize @timetable
    respond_to do |format|
      if @timetable.save
        format.html { redirect_to edit_garage_timetable_url(@garage, @timetable), notice: "Timetable was successfully created." }
      else
        format.html { render :new }
      end
    end
  end

  def update
    authorize @timetable
    time_slots = nullify_time_slots
    time_slots = time_slots.merge(timetable_params)
    respond_to do |format|
      if @timetable.update(time_slots)
        format.html { redirect_to edit_garage_timetable_url(@garage, @timetable), notice: "Timetable was successfully updated." }
      else
        format.html { render :edit }
      end
    end
  end

  def destroy
    authorize @timetable
    @timetable.destroy
    respond_to do |format|
      format.html { redirect_to edit_garage_timetable_url(@garage, @garage.timetable), notice: "Timetable was successfully destroyed." }
    end
  end

  private

  def set_garage
    @garage = Garage.find(params[:garage_id])
  end

  def set_timetable
    @timetable = Timetable.find(params[:id])
  end

  def nullify_time_slots
    time_slots = {}
    Date::DAYNAMES.each do |day|
      time_slots = nullify_noon_break(day, time_slots)
      time_slots = nullify_daily_opening(day, time_slots)
    end
    time_slots
  end

  def nullify_noon_break(day, time_slots)
    unless params["#{day.downcase[0, 3]}_noon"]
      time_slots = time_slots.merge({"#{day.downcase[0, 3]}_morning_close" => nil, "#{day.downcase[0, 3]}_afternoon_open" => nil})
    end
    time_slots
  end

  def nullify_daily_opening(day, time_slots)
    if params["#{day.downcase[0, 3]}_long"]
      time_slots = time_slots.merge({"#{day.downcase[0, 3]}_morning_open" => nil, "#{day.downcase[0, 3]}_afternoon_close" => nil})
    end
    time_slots
  end
end
