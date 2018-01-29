class Room < ApplicationRecord
	require 'httparty'
	validates_presence_of :name, :description, :price, :address, :rules, :image_url
	validates_length_of :description, minimum: 5
	has_many :bookings
	has_many :reviews
	belongs_to :city
	has_many :special_prices
	has_many :amenityids
	has_many :amenities,through: :amenityids
	belongs_to :user
	
	after_create :assign_the_lat_and_lon_magnitudes
	before_create :assign_the_role_of_host_to_guest

	def assign_the_role_of_host_to_guest
		if !self.user.role? "admin"
		    self.user.update_attributes(role_id: Role.second.id)

		end
	end	

	def assign_the_lat_and_lon_magnitudes
		response = HTTParty.get("https://maps.googleapis.com/maps/api/geocode/json?address=#{self.address}&key= AIzaSyDM3Af1biJJ6XU1Yy3fKcpjb2zOxReTr9o ")
		self.latitude = response["results"][0]["geometry"]["location"]["lat"]
		self.longitude = response["results"][0]["geometry"]["location"]["lng"]
	end
end

