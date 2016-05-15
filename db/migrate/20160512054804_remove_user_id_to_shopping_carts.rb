class RemoveUserIdToShoppingCarts < ActiveRecord::Migration
  def change
    remove_column :shopping_carts, :user_id, :string
  end
end
