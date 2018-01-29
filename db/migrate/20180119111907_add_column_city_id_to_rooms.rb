class AddColumnCityIdToRooms < ActiveRecord::Migration[5.1]
  def change
    add_column :rooms, :city_id, :integer
  end
end
