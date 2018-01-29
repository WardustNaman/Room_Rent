class CreateSpecialPrices < ActiveRecord::Migration[5.1]
  def change
    create_table :special_prices do |t|
      t.integer :room_id
      t.string :price
      t.string :start_date
      t.string :end_date

      t.timestamps
    end
  end
end
