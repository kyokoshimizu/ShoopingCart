class CreateShoppingCarts < ActiveRecord::Migration
  def change
    create_table :shopping_carts do |t|
      t.string :user_id
      t.datetime :oder_day

      t.timestamps
    end
  end
end
