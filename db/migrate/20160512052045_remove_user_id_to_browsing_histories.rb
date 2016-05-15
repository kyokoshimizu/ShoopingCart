class RemoveUserIdToBrowsingHistories < ActiveRecord::Migration
  def change
    remove_column :browsing_histories, :user_id, :string
  end
end
