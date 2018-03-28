class AddUserIdToReadingGoals < ActiveRecord::Migration[5.1]
  def change
  	add_column :reading_goals, :user_id, :integer
  end
end
