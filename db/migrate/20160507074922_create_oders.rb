class CreateOders < ActiveRecord::Migration
  def change
    create_table :oders do |t|
      t.integer :shopping_cart_id
      t.string :name
      t.string :address
      t.integer :payment_method
      t.integer :phone_number

      t.timestamps
    end
  end
end
