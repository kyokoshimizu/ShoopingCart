class AddColumnOrders < ActiveRecord::Migration
  def change
  	add_column :orders, :postal, :integer
  end
end
