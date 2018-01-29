class Amenityid < ApplicationRecord
	belongs_to :amenity
	belongs_to :room
end
