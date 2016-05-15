class CreateCartDetails < ActiveRecord::Migration
  def change
    create_table :cart_details do |t|
      t.integer :shopping_cart_id
      t.integer :material_id
      t.integer :num

      t.timestamps
    end
  end
end
