class ChangeColumn < ActiveRecord::Migration[5.1]
  def up
  	 change_column :bookings, :is_confirmed ,:boolean ,default: :false
  end
end
