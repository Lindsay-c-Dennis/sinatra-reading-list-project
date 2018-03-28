class ReadingGoalsController < ApplicationController 
  
  get '/reading_goals/new' do 
    if logged_in?
    	erb :'/reading_goals/new'
    else
      flash[:message] = "You must be signed in to view that page"
    	redirect to '/'
    end
  end 

  get '/reading_goals/:id' do
    if logged_in?
    	@goal = ReadingGoal.find_by_id(params[:id])
  		erb :'/reading_goals/show'
  	else
      flash[:message] = "You must be signed in to view that page"
  		redirect to '/'
  	end
  end			

  get '/reading_goals/:id/edit' do 
    @goal = ReadingGoal.find_by_id(params[:id])
    if logged_in? && current_user.id == @goal.user_id
      erb :'/reading_goals/edit'
    else
      flash[:message] = "You must be signed in to view that page"
      redirect to '/'
    end
  end 

  patch '/reading_goals/:id/edit' do 
    @goal = ReadingGoal.find_by_id(params[:id])
    @goal.update(content: params[:content])
    redirect to '/users/:id'
  end  

  delete '/reading_goals/:id/delete' do 
  	@goal = ReadingGoal.find_by_id(params[:id])
  	@goal.delete
  	redirect to "/users/:id"
  end      

  post '/reading_goals' do
     if params[:content] != ""
       @goal = ReadingGoal.create(content: params[:content])
       current_user.reading_goals << @goal
       redirect to '/users/:id'
      else
        redirect to '/reading_goals/new' 
      end  
  end 		


end