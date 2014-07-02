class TimetablesController < ApplicationController
  before_action :set_garage

  def index
    @timetables = @garage.timetables
  end

  private
    def set_garage
      @garage = Garage.find(params[:garage_id])
    end

    def timetable_params
      params.require(:timetable).permit(:day, :morning_opening, :morning_closing, :afternoon_opening, :afternoon_closing, :garage_id)
    end
end
