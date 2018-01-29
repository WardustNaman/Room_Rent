class Booking < ApplicationRecord
	validates_presence_of :start_date, :end_date, :user_id, :room_id
	belongs_to :room
	belongs_to :user
	validate :check_valid_dates, on: :create
	validate :check_booking_dates, on: :create
	validate :total_price, on: :create
	after_create :send_email_to_host_guest
	after_update :confirmation_mail_to_guest

	def check_valid_dates
		if self.start_date < Date.today
			self.errors.add(:error, "Your start date cant be before todays date")
		end
		if self.end_date < self.start_date
			self.errors.add(:error, "Your end date should be after start date")
		end
	end

	def check_booking_dates
		
		Booking.where("room_id = ? AND end_date >= ?", self.room.id,Date.today).each do |bookings_over|
				self.check(bookings_over)
			end
	end

	def check(bookings_over)
		present_booking = (self.start_date..self.end_date).to_a
			(bookings_over.start_date..bookings_over.end_date).to_a.each do |already_booked|
				if present_booking.include? already_booked
					self.errors.add(:error, "Room is already booked for the present dates ")
				end
			break
		end
	end


	def total_price
		if self.room.special_prices.any?
			present_booking = (self.start_date..self.end_date).to_a
			special_price_dates = SpecialPrice.where("room_id = ?", self.room_id)
			self.price = 0
			special_price_dates.each do |special_price|
				present_booking.each do |date|
					if(special_price.start_date..special_price.end_date).to_a.include? date
						self.price += special_price.price
					else
						self.price += self.room.price
					end
				end
			end
		else
			self.price = self.room.price * (self.start_date..self.end_date).to_a.length
		end
	end

	def send_email_to_host_guest
		NotificationMailer.booking_created(self).deliver_later(wait: 5.minutes)
		NotificationMailer.booking_confirmation(self).deliver_later
	end

	def confirmation_mail_to_guest
		NotificationMailer.booking_status(self).deliver_later
	end

end
