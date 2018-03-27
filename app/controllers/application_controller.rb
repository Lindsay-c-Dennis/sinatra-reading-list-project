require './config/environment'

class ApplicationController < Sinatra::Base

  configure do
    set :public_folder, 'public'
    set :views, 'app/views'
    enable :sessions
    set :session_secret, "moby_dick"
  end

  get '/' do 
  	erb :index 
  end 

  get '/login' do 
  	if logged_in?
  		redirect to '/users/:id'
  	else	
  	    erb :'/users/login'
  	end    
  end 

  get '/signup' do 
  	erb :'/users/signup'
  end

  get '/reading_list' do 
    erb :social
  end 	

  get '/books/new' do 
  	@authors = Author.all
  	@books = Book.all
  	erb :'/books/new'
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
    	redirect to '/reading_list'
    else 
        redirect to '/signup'
    end     	
  end 

  post '/books' do 
  	if logged_in?
      @book = Book.create(params[:book])
      if !params["author"]["name"].empty?
        @book.author = Author.create(name: params["author"]["name"])
      end 
      @book.save
      redirect to "books/#{@book.id}"   
  	else
  	  redirect to '/login'
  	end     
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