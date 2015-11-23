class CreateAddresses < ActiveRecord::Migration
  def change
    create_table :addresses do |t|
      t.references :user, index: true, foreign_key: true
      t.text :street
      t.text :address_line2
      t.text :city
      t.text :county
      t.text :post_code

      t.timestamps null: false
    end
  end
end
