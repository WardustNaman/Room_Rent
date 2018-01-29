class RoomsController < ApplicationController
  before_action :set_room, only: [:show, :edit, :update, :destroy]
  before_action :authenticate_user!,except: [:index]
  # load_and_authorize_resource

  # GET /rooms
  # GET /rooms.json
  def index
    @rooms = Room.where("is_authorized = ?", true).paginate(:page => params[:page], :per_page => 3)
  end

  # GET /rooms/1
  # GET /rooms/1.json
  def show
    @review = Review.new
    @booking = Booking.new
    @special_price = SpecialPrice.new
  end

  # GET /rooms/new
  def new
    @room = Room.new
  end

  # GET /rooms/1/edit
  def edit
    @room = Room.find(params[:id])
  end

  # POST /rooms
  # POST /rooms.json
  def create
    @room = Room.new(room_params)
    respond_to do |format|
      @room.user_id = current_user.id
      if @room.save
        # NotificationMailer.order_confirmation(@room).deliver!
        format.html { redirect_to @room, notice: 'Room was successfully created.' }
        format.json { render :show, status: :created, location: @room }
      else
        format.html { render :new }
        format.json { render json: @room.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /rooms/1
  # PATCH/PUT /rooms/1.json
  def update
    @room = Room.find(params[:id])
    respond_to do |format|
      if @room.update(room_params)
        NotificationMailer.order_confirmation(@room).deliver_later!
        format.html { redirect_to @room, notice: 'Room was successfully updated.' }
        format.json { render :show, status: :ok, location: @room }
      else
        format.html { render :edit }
        format.json { render json: @room.errors, status: :unprocessable_entity }
      end
    end
  end

  def my_rooms
    @rooms = current_user.rooms
  end

  def unauthorized_rooms
    @rooms = Room.where("is_authorized = ?", false)
  end 

  # DELETE /rooms/1
  # DELETE /rooms/1.json
  def destroy
    @room = Room.find(params[:id])
    @room.destroy
    respond_to do |format|
      format.html { redirect_to rooms_url, notice: 'Room was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_room
      @room = Room.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def room_params
      params.require(:room).permit(:name, :description, :city_id, :price, :address, :rules, :role_id, :image_url, :is_authorized, amenity_ids: [])
    end
end



# :latitude, :longitude,