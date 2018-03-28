class CreateReadingGoals < ActiveRecord::Migration[5.1]
  def change
  	create_table :reading_goals do |t|
  		t.string :content 
  	end
  end
end
