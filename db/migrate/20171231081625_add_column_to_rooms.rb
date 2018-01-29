class AddColumnToRooms < ActiveRecord::Migration[5.1]
  def change
  	add_column :rooms, :longitude, :string
  	add_column :rooms, :latitude, :string
  end
end
