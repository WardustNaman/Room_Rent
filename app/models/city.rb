class City < ApplicationRecord
	has_many :rooms

	validates_uniqueness_of :name
	validates_presence_of :name
	validates_length_of :name, :minimum => 3

end
