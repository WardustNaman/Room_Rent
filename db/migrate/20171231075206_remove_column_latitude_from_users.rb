class RemoveColumnLatitudeFromUsers < ActiveRecord::Migration[5.1]
  def change
  remove_column :users, :latitude
  end
end
