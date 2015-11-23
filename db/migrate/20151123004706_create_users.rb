class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.text :first_name
      t.text :middle_name
      t.text :last_name
      t.string :username
      t.string :email
      t.string :crypted_password
      t.string :password_salt
      t.string :persistence_token
      t.text :phone
      t.boolean :patient, default: true
      t.boolean :doctor, default: false
      t.boolean :admin, default: false

      t.timestamps null: false
    end
  end
end
