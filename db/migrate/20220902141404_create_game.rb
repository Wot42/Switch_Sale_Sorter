class CreateGame < ActiveRecord::Migration[7.0]
  def change
    create_table :game do |t|
      t.string :title
      t.string :pic
      t.integer :price
      t.integer :sale_price
      t.string :genre
      t.string :api_id

      t.timestamps
    end
  end
end
