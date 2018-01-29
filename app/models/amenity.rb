class Amenity < ApplicationRecord
	validates_presence_of :name, :description
	validates_uniqueness_of :name
	has_many :amenityids
	has_many :rooms,through: :amenityids
end
