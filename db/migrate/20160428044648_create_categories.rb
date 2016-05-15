class CreateCategories < ActiveRecord::Migration
  def change
    create_table :categories do |t|
      t.integer :material_id
      t.integer :category

      t.timestamps
    end
  end
end
