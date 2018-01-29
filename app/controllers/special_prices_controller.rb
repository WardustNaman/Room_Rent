class SpecialPricesController < ApplicationController
  # before_action :set_special_price, only: [:show, :edit, :update, :destroy]
  before_action :authenticate_user!
  load_and_authorize_resource

  # GET /special_prices
  # GET /special_prices.json
  def index
    @special_prices = SpecialPrice.all
  end

  # GET /special_prices/1
  # GET /special_prices/1.json
  def show
    @room = Room.find(params[:room_id])
    @special_price = SpecialPrice.find(params[:id])
  end

  # GET /special_prices/new
  def new
    @room = Room.find(params[:room_id])
    @special_price = SpecialPrice.new
  end

  # GET /special_prices/1/edit
  def edit
    @room = Room.find(params[:room_id])
    @special_price = SpecialPrice.find(params[:id])
  end

  # POST /special_prices
  # POST /special_prices.json
  def create
    @special_price = SpecialPrice.new(special_price_params)
    @special_price.room_id = params[:room_id]
    respond_to do |format|
      if @special_price.save
        format.html { redirect_to @special_price, notice: 'Special price was successfully created.' }
        format.json { render :show, status: :created, location: @special_price }
      else
        format.html { render :new }
        format.json { render json: @special_price.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /special_prices/1
  # PATCH/PUT /special_prices/1.json
  def update
    @room = Room.find(params[:room_id])
    @special_price = SpecialPrice.find(params[:id])
    respond_to do |format|
      if @special_price.update(special_price_params)
        format.html { redirect_to @special_price, notice: 'Special price was successfully updated.' }
        format.json { render :show, status: :ok, location: @special_price }
      else
        format.html { render :edit }
        format.json { render json: @special_price.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /special_prices/1
  # DELETE /special_prices/1.json
  def destroy
    @room = Room.find(params[:room_id])
    @special_price = SpecialPrice.find(params[:id])
    @special_price.destroy
    respond_to do |format|
      format.html { redirect_to special_prices_url, notice: 'Special price was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_special_price
      @special_price = SpecialPrice.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def special_price_params
      params.require(:special_price).permit(:room_id, :price, :start_date, :end_date)
    end
end
