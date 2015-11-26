class AddNhsNumberToUsers < ActiveRecord::Migration
  def change
	  add_column :users, :nhs_number, :integer
	  add_column :users, :title, :text
	  add_column :users, :dob, :date
	  add_column :users, :gender, :text

  end
end
