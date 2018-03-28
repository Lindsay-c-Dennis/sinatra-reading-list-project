class BooksController < ApplicationController 
  
  get '/books' do 
    if logged_in?
      erb :'/books/index'
    else
      redirect to '/'
    end
  end       
  
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
      redirect to '/'	
    end  
  end   	

  get '/books/new' do 
  	if logged_in?
      @authors = Author.all
  	  @books = Book.all
  	  erb :'/books/new'
  	else 
  	  redirect to '/' 
  	end   
  end

  get '/books/:id' do 
    if logged_in?
      @book = Book.find_by_id(params[:id]) 
  	  erb :'/books/show'
  	else 
  	  redirect to '/'
  	end    
  end 

  get '/books/:id/edit' do 
  	if logged_in?
  		@book = Book.find_by_id(params[:id])
  		erb :'/books/edit'
  	else
  	    redirect to '/'
  	end
  end 
  
  post '/books' do 
  	if params["book"]["title"] == ""
      redirect to '/books/new'
    elsif !params["book"]["author_id"] && params["author"]["name"].empty?
      redirect to '/books/new'
    elsif logged_in? 
      @book = Book.create(params[:book])
      if !params["author"]["name"].empty?
        @book.author = Author.find_or_create_by(name: params["author"]["name"])
      end 
      @book.save
      current_user.books << @book
      redirect to "/users/:id"   
  	else
  	  redirect to '/'
  	end     
  end 
  
  post '/books/add' do 
    if logged_in?
      @book = Book.find_by_id(params["book"]["id"])
      current_user.books << @book 
      redirect to '/users/:id'
    else 
      redirect to '/'
    end 
  end       

  patch '/books/:id' do 
  	if logged_in?
      @book = Book.find_by_id(params[:id])
    	@book.update(params[:book])
    	redirect to '/users/:id'
    else 
      redirect to '/'
    end    
  end	

  delete '/books/:id/delete' do 
    if logged_in?
      @book = Book.find_by_id(params[:id])
      current_user.books.delete(@book)
      redirect to '/users/:id'
    else 
      redirect to '/'
    end    
  end
	    	
end