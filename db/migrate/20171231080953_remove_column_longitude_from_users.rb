class RemoveColumnLongitudeFromUsers < ActiveRecord::Migration[5.1]
  def change
  	remove_column :users, :longitude
  end
end
