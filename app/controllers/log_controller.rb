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
                   flash[:log_new_fail] = "Please ensure all fields are filled out"
                   redirect '/plants/logs/new'
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
                   flash[:wrongful_log_edit] = "Sorry, You're not permitted to edit that Log."
                   redirect '/account'
                end
           end
    
           patch "/logs/:id" do
             redirect_if_not_logged_in 
             @log = current_user.logs.find_by(:id => params[:id])
                if  !@log
                  flash[:wrongful_log_edit] = "Sorry, You're not permitted to edit that Log."
                  redirect '/account'
                elsif @log && !params[:log].values.any?{|v| v.empty?} 
                    @plant = Plant.find(@log.plant_id)
                    @log.update(params[:log])  
                    redirect to "/plants/#{@plant.id}"
                else
                    flash[:log_edit_fail] = "Please ensure all fields are filled out"
                    redirect to "/logs/#{@log.id}/edit"
                      
                end
            end
            
        
    
           get '/logs/:id' do
            redirect_if_not_logged_in
            @log = current_user.logs.find_by(:id => params[:id])
              
                if @log
                   @plant = Plant.find(@log.plant_id)
                   erb :'logs/delete'
                else 
                   flash[:wrong_delete_path] = "That Log's Delete Path Forbidden"
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
                    flash[:wrongful_delete_attempt] = "You're not permitted to delete Log!"
                    redirect to "/account"
                  end
           end

        

end
