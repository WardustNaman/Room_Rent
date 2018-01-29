class CreateAmenityids < ActiveRecord::Migration[5.1]
  def change
    create_table :amenityids do |t|
      t.integer :amenity_id
      t.integer :room_id

      t.timestamps
    end
  end
end
