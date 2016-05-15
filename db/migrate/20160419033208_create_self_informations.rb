class CreateSelfInformations < ActiveRecord::Migration
  def change
    create_table :self_informations do |t|
    	t.integer :member_id
      t.string :name
      t.string :address
      t.string :payment_method
      t.integer :phone_number

      t.timestamps
    end
  end
end