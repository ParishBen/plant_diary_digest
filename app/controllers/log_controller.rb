class LogController < ApplicationController
   
    get '/plants/logs/new' do
        redirect_if_not_logged_in
           @user = current_user
             @conditions = ["Dead", "Far Worse", "Slightly Worse", "About the Same", "Slightly Livelier", "Much Healthier", "Healthiest Yet!"]
              if @user
               erb :'logs/new'
             end
    end

        post '/plants/logs' do 
            @plant = current_user.plants.find_by(:id => params["user_plant"])
              @log= Log.new(:watered_date => params[:watered_date], :condition_update=> params[:condition_update], :content=> params[:content]) 
                if @plant && !params[:condition_update].empty? && !params[:content].empty? && !params[:watered_date].empty?
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
            redirect_if_not_logged_in
            @log = current_user.logs.find_by(:id => params[:id])
                if @log
                    @plant = Plant.find(@log.plant_id)
                    @conditions = ["Dead", "Far Worse", "Slightly Worse", "About the Same", "Slightly Livelier", "Much Healthier", "Healthiest Yet!"]
                    erb :'logs/edit'
                else
                   erb :'logs/log_failure'
                end
           end
    
           patch "/logs/:id" do
             redirect_if_not_logged_in 
             @log = current_user.logs.find_by(:id => params[:id])
                if  !@log
                    erb :'logs/log_edit_fail'
                elsif @log && !params[:log].values.any?{|v| v.empty?} 
                    @plant = Plant.find(@log.plant_id)
                    @log.update(params[:log])  
                    redirect to "/plants/#{@plant.id}"
                else
                    erb :'logs/log_edit_fail'
                      
                end
            end
            
        
    
           get '/logs/:id' do
            redirect_if_not_logged_in
            @log = current_user.logs.find_by(:id => params[:id])
              
                if @log
                   @plant = Plant.find(@log.plant_id)
                   erb :'logs/delete'
                else 
                   redirect '/account'
                end
           end
        
           
           get '/plants/logs/:id' do 
            @plant = Plant.find_by(:id=> params[:id])
              if !logged_in?
                erb :'plants/other_show'
              elsif @plants = current_user.plants.find_by(:id=> @plant.id)
                   erb :'plants/show'
              else
                   erb :'plants/other_show'
                end
            end

           delete "/logs/:id" do
            redirect_if_not_logged_in
            @log = current_user.logs.find_by(:id => params[:id]) 
                  if @log
                    @plant = Plant.find(@log.plant_id)
                      Log.destroy(params[:id])
                      redirect to "/plants/#{@plant.id}"
                  else
                    redirect to "/account"
                  end
           end

        

end
