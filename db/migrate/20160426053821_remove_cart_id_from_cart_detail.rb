class RemoveCartIdFromCartDetail < ActiveRecord::Migration
  def change
    remove_column :cart_details, :cart_id, :integer
  end
end
