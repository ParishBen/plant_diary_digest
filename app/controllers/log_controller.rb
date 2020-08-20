class LogController < ApplicationController
   
    get '/plant/log/new' do
        if !logged_in?
            redirect to '/'
        elsif
        @user = current_user
        
        @conditions = ["Dead", "Far Worse", "Slightly Worse", "About the Same", "Slightly Livelier", "Much Healthier", "Healthiest Yet!"]
        if @user
        erb :log
    
        end
    end
end
        post '/plant/logs' do 
            @plant = Plant.find_by(:id=>params["user_plant"])
            
            @log= Log.new(:watered_date => params[:watered_date], :condition_update=> params[:condition_update], :content=> params[:content]) 
            if !params[:condition_update].empty? && !params[:content].empty? && !params[:watered_date].empty?
                @log.plant_id= @plant.id
             @log.save
             erb :plant_show
               else 
                redirect '/log_failure'
                 end 
                end
        
           get '/log_failure' do
            erb :log_failure
            end

           get '/log/:id/edit' do
            if !logged_in?
                redirect to '/'
            elsif

            @log = Log.find_by(:id=>params[:id])
            @plant = Plant.find(@log[:plant_id])
            @logs = current_user.logs
            if @logs.find_by(:id=>@log.id)
            @conditions = ["Dead", "Far Worse", "Slightly Worse", "About the Same", "Slightly Livelier", "Much Healthier", "Healthiest Yet!"]
            erb :edit
            else
                erb :log_failure
           end
        end
    end
           patch "/log/:id" do

           @log = Log.find(params[:id])
           @plant = Plant.find(@log[:plant_id])
           if !params[:log].empty?
           @log.update(params[:log])  
           
           redirect "/plant/log/#{ @plant.id}"
           else redirect to "/log/#{@log.id}/edit"
           end
        end
           
           get '/log/:id' do
            if !logged_in?
                redirect to '/'
            elsif
           @log = Log.find(params[:id])
           @plant = Plant.find(@log[:plant_id])
           @logs = current.user.logs
           if @logs.find_by(:id=>@log.id)
           erb :delete
           else redirect '/account'
           end
          end
        end
           
           get '/plant/log/:id' do 
            @plant = Plant.find(params[:id])
            if !logged_in?
               erb :other_show
            elsif 
                @plants= current_user.plants
                if @plants.find_by(:id=>@plant.id)
               erb :plant_show
                else
                    erb :other_show
                end
                   
           end
        end

           delete "/log/:id" do
            @log = Log.find(params[:id])
            @plant = Plant.find(@log[:plant_id])
            Log.destroy(params[:id])
            
            redirect to "/plant/#{@plant.id}"
           end

        

end
