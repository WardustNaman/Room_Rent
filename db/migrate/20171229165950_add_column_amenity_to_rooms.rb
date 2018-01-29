class AddColumnAmenityToRooms < ActiveRecord::Migration[5.1]
  def change
  	add_column :rooms, :amenity, :boolean
  end
end
