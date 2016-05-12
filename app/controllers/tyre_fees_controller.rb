class TyreFeesController < ApplicationController
  before_action :set_tyre_fee, only: [:show, :edit, :update, :destroy]
  before_action :set_garage
  after_action :verify_authorized

  def index
    redirect_to user_path(current_user) unless policy(@garage).show?
    tyre_fees = @garage.tyre_fees.page(params[:page])
    authorize tyre_fees
    @tyre_fees = TyreFeeDecorator.decorate_collection(tyre_fees)
  end

  def new
    @tyre_fee = @garage.tyre_fees.build
    authorize @tyre_fee
  end

  def edit
    authorize @tyre_fee
  end

  def create
    @tyre_fee = TyreFee.create(tyre_fee_params)
    authorize @tyre_fee
    respond_to do |format|
      if @tyre_fee.save
        format.html { redirect_to garage_tyre_fees_url(@garage), notice: "Tyre fee was successfully created." }
      else
        format.html { render :new }
      end
    end
  end

  def update
    authorize @tyre_fee
    respond_to do |format|
      if @tyre_fee.update(tyre_fee_params)
        format.html { redirect_to garage_tyre_fees_url(@garage), notice: "Tyre fee was successfully updated." }
      else
        format.html { render :edit }
      end
    end
  end

  def destroy
    authorize @tyre_fee
    @tyre_fee.destroy
    respond_to do |format|
      format.html { redirect_to garage_tyre_fees_url, notice: "Tyre fee was successfully destroyed." }
    end
  end

  private

  def set_tyre_fee
    @tyre_fee = TyreFee.find(secure_id)
  end

  def set_garage
    @garage = Garage.find(secure_garage_id)
  end

  def secure_id
    params[:id].to_i
  end

  def secure_garage_id
    params[:garage_id].to_i
  end

  def tyre_fee_params
    params.require(:tyre_fee).permit(:name, :price, :vehicle_type, :diameter_min, :diameter_max, :rim_type, :garage_id)
  end
end
