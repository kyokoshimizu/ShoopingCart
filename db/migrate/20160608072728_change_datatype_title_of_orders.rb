class ChangeDatatypeTitleOfOrders < ActiveRecord::Migration
  def change
  	change_column :orders, :phone_number, :string
  	change_column :orders, :postal, :string
  end
end
