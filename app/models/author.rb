class Author < ActiveRecord::Base 
	has_many :books
	has_many :author_users
	has_many :users, through: :author_users
end