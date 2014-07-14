class TyreFeesController < ApplicationController
  before_action :set_tyre_fee, only: [:show, :edit, :update, :destroy]
  before_action :set_garage

  # GET /tyre_fees
  # GET /tyre_fees.json
  def index
    tyre_fees = TyreFee.by_garage(@garage).page(params[:page])
    @tyre_fees = TyreFeeDecorator.decorate_collection(tyre_fees)
  end

  # GET /tyre_fees/1
  # GET /tyre_fees/1.json
  def show
  end

  # GET /tyre_fees/new
  def new
    @fee = Fee.new
    @tyre_fee = TyreFee.new
  end

  # GET /tyre_fees/1/edit
  def edit
    @tyre_fee = TyreFee.find(params[:id])
    @fee = Fee.find(@tyre_fee.fee)
  end

  # POST /tyre_fees
  # POST /tyre_fees.json
  def create
    @fee = Fee.new(fee_params)
    @tyre_fee = TyreFee.new(tyre_fee_params)
    @fee.garage = @garage
    @tyre_fee.fee = @fee
    respond_to do |format|
      if @fee.save
        if @tyre_fee.save
          format.html { redirect_to garage_tyre_fee_url(@garage, @tyre_fee), notice: "Tyre fee was successfully created." }
          format.json { render :show, status: :created, location: @tyre_fee }
        else
          format.html { render :new }
          format.json { render json: @tyre_fee.errors, status: :unprocessable_entity }
        end
      else
        format.html { render :new }
        format.json { render json: @fee.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /tyre_fees/1
  # PATCH/PUT /tyre_fees/1.json
  def update
    respond_to do |format|
      if @fee.update(fee_params)
        if @tyre_fee.update(tyre_fee_params)
          format.html { redirect_to garage_tyre_fee_url(@garage, @tyre_fee), notice: "Tyre fee was successfully updated." }
          format.json { render :show, status: :ok, location: @tyre_fee }
        else
          format.html { render :edit }
          format.json { render json: @tyre_fee.errors, status: :unprocessable_entity }
        end
      else
        format.html { render :edit }
        format.json { render json: @fee.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /tyre_fees/1
  # DELETE /tyre_fees/1.json
  def destroy
    @tyre_fee.destroy
    @fee.destroy
    respond_to do |format|
      format.html { redirect_to garage_tyre_fees_url, notice: "Tyre fee was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private

  def set_tyre_fee
    @tyre_fee = TyreFee.find(params[:id])
    @fee = Fee.find(@tyre_fee.fee)
  end

  def set_garage
    @garage = Garage.find(params[:garage_id])
  end

  def tyre_fee_params
    params.require(:tyre_fee).permit(:vehicle_type, :diameter_min, :diameter_max, :rim_type)
  end

  def fee_params
    params.require(:fee).permit(:name, :price)
  end
end
