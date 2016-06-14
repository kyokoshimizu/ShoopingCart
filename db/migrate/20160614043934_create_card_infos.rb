class CreateCardInfos < ActiveRecord::Migration
  def change
    create_table :card_infos do |t|
      t.integer :self_information_id
      t.integer :order_id
      t.string :card_num
      t.integer :deadline
      t.integer :times
      t.string :code

      t.timestamps
    end
  end
end
