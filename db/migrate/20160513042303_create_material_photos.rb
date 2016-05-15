class CreateMaterialPhotos < ActiveRecord::Migration
  def change
    create_table :material_photos do |t|
      t.integer :material_id
      t.binary :photo
      t.string :photo_content_type

      t.timestamps
    end
  end
end
