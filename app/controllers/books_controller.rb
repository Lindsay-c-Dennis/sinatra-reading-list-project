class BooksController < ApplicationController 
  
  get '/books/add' do 
    if logged_in?
      @new_books = []
      Book.all.each do |book|
        if !current_user.books.include?(book)
        	@new_books << book 
        end	
      end
      erb :'/books/add_from_library'
    else 
      redirect to '/login'	
    end  
  end   	

  get '/books/new' do 
  	if logged_in?
      @authors = Author.all
  	  @books = Book.all
  	  erb :'/books/new'
  	else 
  	  redirect to '/login' 
  	end   
  end

  get '/books/:id' do 
    if logged_in?
      @book = Book.find_by_id(params[:id]) 
  	  erb :'/books/show'
  	else 
  	  redirect to '/login'
  	end    
  end 

  get '/books/:id/edit' do 
  	if logged_in?
  		@book = Book.find_by_id(params[:id])
  		erb :'/books/edit'
  	else
  	    redirect to '/login'
  	end
  end 
  
  post '/books' do 
  	if logged_in?
      @book = Book.find_or_create_by(title: params["book"]["title"])
      if !params["author"]["name"].empty?
        @book.author = Author.find_or_create_by(name: params["author"]["name"])
      else 
        @book.author_id = params["book"]["author_id"]  
      end 
      @book.save
      current_user.books << @book
      redirect to "/users/:id"   
  	else
  	  redirect to '/login'
  	end     
  end 
  
  post '/books/add' do 
    if logged_in?
      @book = Book.find_by_id(params["book"]["id"])
      current_user.books << @book 
      redirect to '/users/:id'
    else 
      redirect to '/login'
    end 
  end       

  patch '/books/:id' do 
  	@book = Book.find_by_id(params[:id])
  	@book.update(params[:book])
  	redirect to '/users/:id'
  end	

  delete '/books/:id/delete' do 
    @book = Book.find_by_id(params[:id])
    current_user.books.delete(@book)
    redirect to '/users/:id'
  end
	    	
end