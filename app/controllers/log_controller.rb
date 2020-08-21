class LogController < ApplicationController
   
    get '/plants/logs/new' do
        if !logged_in?
            redirect to '/'
        elsif
        @user = current_user
        
        @conditions = ["Dead", "Far Worse", "Slightly Worse", "About the Same", "Slightly Livelier", "Much Healthier", "Healthiest Yet!"]
        if @user
        erb :'logs/log'
    
        end
    end
end
        post '/plants/logs' do 
            @plant = Plant.find_by(:id=>params["user_plant"])
            
            @log= Log.new(:watered_date => params[:watered_date], :condition_update=> params[:condition_update], :content=> params[:content]) 
            if !params[:condition_update].empty? && !params[:content].empty? && !params[:watered_date].empty?
                @log.plant_id= @plant.id
             @log.save
             redirect to "/plants/#{@plant.id}"
               else 
                redirect '/log_failure'
                 end 
                end
        
           get '/log_failure' do
            erb :'logs/log_failure'
            end

           get '/logs/:id/edit' do
            if !logged_in?
                redirect to '/'
            elsif

            @log = Log.find_by(:id=>params[:id])
            @plant = Plant.find(@log[:plant_id])
            @logs = current_user.logs
            if @logs.find_by(:id=>@log.id)
            @conditions = ["Dead", "Far Worse", "Slightly Worse", "About the Same", "Slightly Livelier", "Much Healthier", "Healthiest Yet!"]
            erb :'logs/edit'
            else
                erb :'logs/log_failure'
           end
        end
    end
           patch "/logs/:id" do

           @log = Log.find(params[:id])
           @plant = Plant.find(@log[:plant_id])
           
           if !params[:log].values.any?{|v| v.empty?} 
           
            @log.update(params[:log])  
           
           redirect to "/plants/#{ @plant.id}"
           
        else
             erb :'logs/log_edit_fail'
             
           end
        end
    
           get '/logs/:id' do
            if !logged_in?
                redirect to '/'
            elsif
           @log = Log.find(params[:id])
           @plant = Plant.find(@log[:plant_id])
           @logs = current.user.logs
           if @logs.find_by(:id=>@log.id)
           erb :'logs/log_delete'
           else redirect '/account'
           end
          end
        end
           
           get '/plants/logs/:id' do 
            @plant = Plant.find(params[:id])
            if !logged_in?
               erb :'plants/other_show'
            elsif 
                @plants= current_user.plants
                if @plants.find_by(:id=>@plant.id)
               erb :'plants/plant_show'
                else
                    erb :'plants/other_show'
                end
                   
           end
        end

           delete "/logs/:id" do
            @log = Log.find(params[:id])
            @plant = Plant.find(@log[:plant_id])
            Log.destroy(params[:id])
            
            redirect to "/plants/#{@plant.id}"
           end

        

end
