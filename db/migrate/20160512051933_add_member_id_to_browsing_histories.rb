class AddMemberIdToBrowsingHistories < ActiveRecord::Migration
  def change
    add_column :browsing_histories, :member_id, :integer
  end
end
