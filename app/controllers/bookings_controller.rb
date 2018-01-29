class BookingsController < ApplicationController
	before_action :set_booking, only: [:show, :edit, :update, :destroy]
	def index
		@bookings = current_user.bookings
	end
	def show
	end

	def new
		@booking = Booking.new
	end

	def edit
	end

	 def create
    @booking = Booking.new(booking_params)

    respond_to do |format|
      @booking.user_id = current_user.id
      if @booking.save
        format.html { redirect_to @booking, notice: 'Booking was successfully created.' }
        format.json { render :show, status: :created, location: @booking }
      else
        format.html { render :new }
        format.json { render json: @booking.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /bookings/1
  # PATCH/PUT /bookings/1.json
  def update
    respond_to do |format|
      if @booking.update(booking_params)
        format.html { redirect_to @booking, notice: 'Booking was successfully updated.' }
        format.json { render :show, status: :ok, location: @booking }
      else
        format.html { render :edit }
        format.json { render json: @booking.errors, status: :unprocessable_entity }
      end
    end
end

	def destroy 
	@booking = Booking.find(params[:id])
	@booking.destroy
     redirect_to bookings_path, notice: "The booking has been successfully cancelled"
	end

	def unconfirmed_bookings
		@bookings = Booking.where("is_confirmed = ?", false)
	end

	def cancel_booking
		@booking.destroy
		redirect_to bookings_cancel_booking_path, notice: "Booking is successfully cancelled"
	end

	private

	def set_booking
		@booking = Booking.find(params[:id])
	end

	def booking_params
		params[:booking].permit(:start_date, :price, :user_id, :end_date, :room_id, :is_confirmed)
	end
end
