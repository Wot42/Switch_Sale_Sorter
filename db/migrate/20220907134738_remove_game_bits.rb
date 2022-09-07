class RemoveGameBits < ActiveRecord::Migration[7.0]
  def change
    remove_column(:games, :price)
    remove_column(:games, :genre)
    remove_column(:games, :sale_price)
  end
end
