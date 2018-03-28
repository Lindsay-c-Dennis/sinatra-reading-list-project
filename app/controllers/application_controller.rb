require './config/environment'

class ApplicationController < Sinatra::Base

  configure do
    set :public_folder, 'public'
    set :views, 'app/views'
    enable :sessions
    set :session_secret, "moby_dick"
  end

  get '/' do 
  	if logged_in?
  		redirect to '/users/:id'
  	else	
  	    erb :index 
  	end    
  end 

  get '/login' do 
  	if logged_in?
  		redirect to '/users/:id'
  	else	
  	    erb :'/users/login'
  	end    
  end 

   get '/logout' do 
    session.clear
    redirect to "/login"
   end 

  get '/signup' do 
  	if logged_in? 
  		redirect to '/users/:id'
  	else	
  	    erb :'/users/signup'
  	end    
  end

  get '/reading_list' do 
    if logged_in?
      erb :social
    else 
      redirect to '/login'
    end    
  end 

  get '/books/add' do 
    if logged_in?
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


  get '/users/:id' do 
  	if logged_in? 
  	  erb :'/users/show'
  	else 
  	  redirect to '/login'
  	end    
  end 

  get '/authors/:id' do 
  	@author = Author.find_by_id(params[:id])
  	if logged_in?
  		erb :'/authors/show'
  	else 
  	    redirect to '/login'
  	end 
  end	  
	
  post '/login' do 
  	@user = User.find_by(username: params[:username])
  	if @user && @user.authenticate(params[:password])
  		session[:user_id] = @user.id 
  		redirect to '/users/:id'
  	else 
  	    redirect to '/login'	
    end
  end 

  post '/signup' do 
    if params[:username] != "" && params[:password] != "" && params[:email] != ""
    	@user = User.create(username: params[:username], password: params[:password], email: params[:email])
    	session[:user_id] = @user.id 
    	redirect to '/users/:id'
    else 
        redirect to '/signup'
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

  
  helpers do

  	def current_user 
  	  @current_user ||= User.find_by(id: session[:user_id]) if session[:user_id]
  	end 

  	def logged_in?
  	  !!current_user
  	end 

  end 
end