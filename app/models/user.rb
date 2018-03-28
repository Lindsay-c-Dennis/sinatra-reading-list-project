class User < ActiveRecord::Base 
  has_many :book_users
  has_many :books, through: :book_users
  has_many :author_users
  has_many :authors, through: :author_users
  has_many :reading_goals
  has_secure_password
end