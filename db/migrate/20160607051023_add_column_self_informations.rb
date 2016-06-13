class AddColumnSelfInformations < ActiveRecord::Migration
  def change
  	add_column :self_informations, :postal, :integer
  end
end
