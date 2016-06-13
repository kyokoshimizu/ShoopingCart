class ChangeDatatypeTitleOfSelfInformations < ActiveRecord::Migration
  def change
  	change_column :self_informations, :phone_number, :string
  	change_column :self_informations, :postal, :string
  end
end
