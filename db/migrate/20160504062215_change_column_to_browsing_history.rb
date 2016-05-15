class ChangeColumnToBrowsingHistory < ActiveRecord::Migration
  def change
  	change_column :browsing_histories, :user_id, :string
  end
end
