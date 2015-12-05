class AddReceptionToUsers < ActiveRecord::Migration
  def change
	  add_column :users, :receptionist, :boolean, default: false
  end
end
