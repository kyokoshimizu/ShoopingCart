class AddMemberIdToShoppingCarts < ActiveRecord::Migration
  def change
    add_column :shopping_carts, :member_id, :integer
  end
end
