class ChangeColumnToPhotos < ActiveRecord::Migration
  def up
  	change_column :photos, :photo, :mediumblob
  end

  def down
   change_column :photos, :photo, :blob
  end
end
