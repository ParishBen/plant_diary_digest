class LogController < ApplicationController
   
    get '/plant/log/new' do
        @user = current_user
        
        @conditions = ["Dead", "Far Worse", "Slightly Worse", "About the Same", "Slightly Livelier", "Much Healthier", "Healthiest Yet!"]
        if @user
        erb :log
        else :failure
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
            @log = Log.find(params[:id])
            @plant = Plant.find(@log[:plant_id])
            
            @conditions = ["Dead", "Far Worse", "Slightly Worse", "About the Same", "Slightly Livelier", "Much Healthier", "Healthiest Yet!"]
            erb :edit
           end
           
           patch "/log/:id" do
           @log = Log.find(params[:id])
           @plant = Plant.find(@log[:plant_id])
           @log.update(params[:log])  
           
           redirect "/plant/log/#{ @plant.id}"
           end
          
           
           get '/log/:id' do
           @log = Log.find(params[:id])
           @plant = Plant.find(@log[:plant_id])
           erb :delete
           end
           
           get '/plant/log/:id' do 
            @plant = Plant.find(params[:id])
            erb :plant_show
           end


           delete "/log/:id" do
            @log = Log.find(params[:id])
            @plant = Plant.find(@log[:plant_id])
            Log.destroy(params[:id])
            
            redirect to "/plant/#{@plant.id}"
           end

        

end
