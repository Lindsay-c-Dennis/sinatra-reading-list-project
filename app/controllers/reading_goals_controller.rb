class ReadingGoalsController < ApplicationController 
  
  get '/reading_goals/new' do 
    if logged_in?
    	erb :'/reading_goals/new'
    else
    	redirect to '/'
    end
  end  

  post '/reading_goals' do
     @goal = ReadingGoal.create(content: params[:content])
     current_user.reading_goals << @goal
     redirect to '/users/:id' 
  end 		


end