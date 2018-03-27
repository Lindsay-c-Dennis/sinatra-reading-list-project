class CreateBookUsers < ActiveRecord::Migration[5.1]
  def change
  	create_table :book_users do |t|
  		t.integer :book_id
  		t.integer :user_id
  	end
  end
end
