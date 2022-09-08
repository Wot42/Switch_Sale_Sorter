class AddNewGameApi < ActiveRecord::Migration[7.0]
  def change
    add_column :games, :tags, :text, array: true, default: []
    add_column :games, :price, :decimal
    add_column :games, :sale_price, :decimal
    add_column :games, :discount_percentage, :decimal
    add_column :games, :url, :string
    add_column :games, :tagline, :text
    add_column :games, :age_rating, :integer
    add_column :games, :players, :integer
    add_column :games, :active_sale, :boolean
    add_column :games, :sale_start, :date
    add_column :games, :sale_end, :date
  end
end
