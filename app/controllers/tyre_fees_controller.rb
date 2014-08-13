class TyreFeesController < ApplicationController
  before_action :set_tyre_fee, only: [:show, :edit, :update, :destroy]
  before_action :set_garage

  def index
    tyre_fees = @garage.tyre_fees.page(params[:page])
    @tyre_fees = TyreFeeDecorator.decorate_collection(tyre_fees)
  end

  def show
  end

  def new
    @tyre_fee = TyreFee.new
  end

  def edit
    @tyre_fee = TyreFee.find(params[:id])
  end

  def create
    @tyre_fee = TyreFee.new(tyre_fee_params)
    respond_to do |format|
      if @tyre_fee.save
        format.html { redirect_to garage_tyre_fee_url(@garage, @tyre_fee), notice: "Tyre fee was successfully created." }
      else
        format.html { render :new }
      end
    end
  end

  def update
    respond_to do |format|
      if @tyre_fee.update(tyre_fee_params)
        format.html { redirect_to garage_tyre_fee_url(@garage, @tyre_fee), notice: "Tyre fee was successfully updated." }
      else
        format.html { render :edit }
      end
    end
  end

  def destroy
    @tyre_fee.destroy
    respond_to do |format|
      format.html { redirect_to garage_tyre_fees_url, notice: "Tyre fee was successfully destroyed." }
    end
  end

  private

  def set_tyre_fee
    @tyre_fee = TyreFee.find(params[:id])
  end

  def set_garage
    @garage = Garage.find(params[:garage_id])
  end

  def tyre_fee_params
    params.require(:tyre_fee).permit(:name, :price, :vehicle_type, :diameter_min, :diameter_max, :rim_type)
  end
end
