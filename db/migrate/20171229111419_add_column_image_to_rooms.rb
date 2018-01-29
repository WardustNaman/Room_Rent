class AddColumnImageToRooms < ActiveRecord::Migration[5.1]
  def change
  	add_column :rooms, :image_url, :string
  end
end
