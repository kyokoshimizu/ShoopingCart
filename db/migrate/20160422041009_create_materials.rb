class CreateMaterials < ActiveRecord::Migration
  def change
    create_table :materials do |t|
      t.string :title
      t.integer :price
      t.integer :size
      t.string :detail

      t.timestamps
    end
  end
end
