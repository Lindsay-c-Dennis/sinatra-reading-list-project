require './config/environment'
require 'rack-flash'

class ApplicationController < Sinatra::Base

  configure do
    set :public_folder, 'public'
    set :views, 'app/views'
    enable :sessions
    set :session_secret, "moby_dick"
    use Rack::Flash
  end

  get '/' do 
  	if logged_in?
  		redirect to '/users/:id'
  	else	
  	    erb :index 
  	end    
  end 

  get '/reading_list' do 
    if logged_in?
      erb :social
    else 
      flash[:message] = "You must be signed in to view that page"
      redirect to '/'
    end    
  end  

  get '/authors' do 
    if logged_in?
    	erb :'/authors/index'
    else
        flash[:message] = "You must be signed in to view that page" 
        redirect to '/'
    end    	
  end 

  get '/authors/:id' do 
  	@author = Author.find_by_id(params[:id])
    if logged_in?
  		erb :'/authors/show'
  	else 
        flash[:message] = "You must be signed in to view that page"
  	    redirect to '/'
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