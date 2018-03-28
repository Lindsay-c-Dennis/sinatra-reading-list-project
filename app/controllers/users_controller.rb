class UsersController < ApplicationController 

	get '/login' do 
	  	if logged_in?
	  		redirect to '/users/:id'
	  	else	
	  	    erb :'/users/login'
	  	end    
	  end 

	   get '/logout' do 
	    session.clear
	    redirect to "/"
	   end 

	  get '/signup' do 
	  	if logged_in? 
	  		redirect to '/users/:id'
	  	else	
	  	    erb :'/users/signup'
	  	end    
	  end

	get '/users/:id' do 
  	  if logged_in? 
  	    erb :'/users/show'
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

end