class ReadingGoalsController < ApplicationController 
  
  get '/reading_goals/new' do 
    if logged_in?
    	erb :'/reading_goals/new'
    else
    	redirect to '/'
    end
  end 

  get '/reading_goals/:id/edit' do 
    @goal = ReadingGoal.find_by_id(params[:id])
    if logged_in? && current_user.id == @goal.user_id
      erb :'/reading_goals/edit'
    else
      redirect to '/'
    end
  end 

  patch '/reading_goals/:id/edit' do 
    @goal = ReadingGoal.find_by_id(params[:id])
    @goal.update(content: params[:content])
    redirect to '/users/:id'
  end  

       

  post '/reading_goals' do
     @goal = ReadingGoal.create(content: params[:content])
     current_user.reading_goals << @goal
     redirect to '/users/:id' 
  end 		


end