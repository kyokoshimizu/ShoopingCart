class CreateBrowsingHistories < ActiveRecord::Migration
  def change
    create_table :browsing_histories do |t|
      t.string :user_id
      t.integer :material_id
      t.datetime :day

      t.timestamps
    end
  end
end
