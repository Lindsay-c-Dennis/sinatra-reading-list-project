     class CreateAuthorUsers < ActiveRecord::Migration[5.1]
       def change
       	 create_table :author_users do |t|
       	   t.integer :author_id
       	   t.integer :user_id 
       	end
       end
     end
