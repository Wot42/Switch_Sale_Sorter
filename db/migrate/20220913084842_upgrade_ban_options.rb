class UpgradeBanOptions < ActiveRecord::Migration[7.0]
  def change
    add_column :ban_hammers, :perma_ban, :bool
    add_column :ban_hammers, :owned, :bool
    add_column :ban_hammers, :until_date, :date
    add_column :ban_hammers, :until_price, :decimal
  end
end
