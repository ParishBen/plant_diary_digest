class LogController < ApplicationController
   
    get '/plant/log/new' do
        @conditions= ["Dead", "Far Worse", "Slightly Worse", "About the Same", "Slightly Livelier", "Much Healthier", "Healthiest Yet!"]
        
    erb :log
    end
        get '/plant/log/:id' do 
            @plant = Plant.find_by(:id=>params[:id])
            erb :plants_log
        end
    
        post '/plant/log/:id' do 
            @plant = Plant.find_by(:id=>params[:id])
            erb :plants_log
        end
        get '/home' do
            erb :home
        end

end
