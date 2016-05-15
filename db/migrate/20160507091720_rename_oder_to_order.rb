class RenameOderToOrder < ActiveRecord::Migration
  def change
  	rename_table :oders, :orders
  end
end
