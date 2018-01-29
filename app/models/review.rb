class Review < ApplicationRecord
	validates_presence_of :body, :user_id, :room_id, :food_rating, :cleanliness_rating, :safety_rating, :facility_rating, :locality_rating
	validates_length_of :body, within: 10...1000
	belongs_to :room
	belongs_to :user

end
