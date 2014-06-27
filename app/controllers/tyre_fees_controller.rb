class TyreFeesController < ApplicationController
  before_action :set_tyre_fee, only: [:show, :edit, :update, :destroy]

  # GET /tyre_fees
  # GET /tyre_fees.json
  def index
    @tyre_fees = TyreFee.all
  end

  # GET /tyre_fees/1
  # GET /tyre_fees/1.json
  def show
  end

  # GET /tyre_fees/new
  def new
    @tyre_fee = TyreFee.new
  end

  # GET /tyre_fees/1/edit
  def edit
  end

  # POST /tyre_fees
  # POST /tyre_fees.json
  def create
    @tyre_fee = TyreFee.new(tyre_fee_params)

    respond_to do |format|
      if @tyre_fee.save
        format.html { redirect_to @tyre_fee, notice: 'Tyre fee was successfully created.' }
        format.json { render :show, status: :created, location: @tyre_fee }
      else
        format.html { render :new }
        format.json { render json: @tyre_fee.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /tyre_fees/1
  # PATCH/PUT /tyre_fees/1.json
  def update
    respond_to do |format|
      if @tyre_fee.update(tyre_fee_params)
        format.html { redirect_to @tyre_fee, notice: 'Tyre fee was successfully updated.' }
        format.json { render :show, status: :ok, location: @tyre_fee }
      else
        format.html { render :edit }
        format.json { render json: @tyre_fee.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /tyre_fees/1
  # DELETE /tyre_fees/1.json
  def destroy
    @tyre_fee.destroy
    respond_to do |format|
      format.html { redirect_to tyre_fees_url, notice: 'Tyre fee was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_tyre_fee
      @tyre_fee = TyreFee.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def tyre_fee_params
      params.require(:tyre_fee).permit(:price)
    end
end