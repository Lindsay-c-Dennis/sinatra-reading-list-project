# Specifications for the Sinatra Assessment

Specs:
- [x] Use Sinatra to build the app
- [x] Use ActiveRecord for storing information in a database - program has a database powered by sqlite3, models inherit from ActiveRecord base
- [x] Include more than one model class - Author, AuthorUser, Book, BookUser, ReadingGoal, User
- [x] Include at least one has_many relationship - User has_many reading_goals, Author has_many books, Users and books have many to many relationship, as do Authors and Users (through books)
- [x] Include user accounts - user accounts can be created
- [x] Ensure that users can't modify content created by other users - this one is a bit tricky. Each user is able to create reading goals that cannot be edited by other users. However, because books and authors have a many to many relationship with users, it is possible for a user to edit a book on their list and impact the data on another user's list. This is probably the biggest weakness of the app, but having the many-to-many relationship allows additional functionality (like a book show page that lists its readers and an 'add this book to my library' button)
- [x] Ensure that the belongs_to resource has routes for Creating, Reading, Updating and Destroying - reading goals can be created, read, updated, and destroyed, books and authors can be updated or removed from a user (not totally deleted)
- [x] Include user input validations - get routes require the user to be logged in, user show page is only visible to current user
- [x] Display validation failures to user with error message - if user tries to navigate to any page except index, login, or signup, they are redirected to the index page and a flash message appears telling them that they must be logged in to view that page.
- [x] Your README.md includes a short description, install instructions, a contributors guide and a link to the license for your code

Confirm
- [x] You have a large number of small Git commits
- [x] Your commit messages are meaningful
- [x] You made the changes in a commit that relate to the commit message
- [x] You don't include changes in a commit that aren't related to the commit message
 Re: commits - this is something I'm working on. Sometimes I get distracted trying to fix a variety of features and I suddenly realize I haven't committed in a while. I did a bad job commiting at the start of the project because I just forgot. But I am actively working on this.