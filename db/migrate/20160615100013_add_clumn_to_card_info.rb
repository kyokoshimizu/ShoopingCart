class AddClumnToCardInfo < ActiveRecord::Migration
  def change
  	add_column :card_infos, :deadline2, :integer
  end
end
