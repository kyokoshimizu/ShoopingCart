class AddShoppingCartIdFromCartDetail < ActiveRecord::Migration
  def change
    add_column :cart_details, :shopping_cart_id, :integer
  end
end