class AddReceptionToUsers < ActiveRecord::Migration
  def change
	  add_column :users, :reception, :boolean, default: false
  end
end
