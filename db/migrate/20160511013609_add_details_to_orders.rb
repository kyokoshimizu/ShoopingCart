class AddDetailsToOrders < ActiveRecord::Migration
  def change
  	add_column :orders, :decide_order, :boolean, default: false, null: false
  end
end
