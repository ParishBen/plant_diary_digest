class PlantController < ApplicationController

    get '/plants/new' do
        redirect_if_not_logged_in
          erb :'plants/new'
    end


    post '/plants' do
       redirect_if_not_logged_in
       @plant= Plant.new(:common_name=> params[:common_name], :plant_type=> params[:plant_type], :nickname=> params[:nickname], :user_id=> params[:user_id])
        if !params[:nickname].empty? && !params[:common_name].empty? && !params[:plant_type].empty?
            @plant.user_id = current_user.id
             @plant.save
              redirect to '/account'
        else 
          flash[:plant_new_fail] = "Sorry we couldn't create that plant. Please try again."
            redirect to '/plants/new'
            
        end 
    end

    get '/plant_failure' do
        erb :'plants/plant_failure'
    end
    
    get '/plants' do
        redirect_if_not_logged_in
            erb :'users/account'
    end


    get '/plants/:id' do 
         @plant = Plant.find_by(:id=> params[:id])
            if !logged_in? 
                erb :'plants/other_show'
            elsif @plants = current_user.plants.find_by(:id=> @plant.id)  
                erb :'plants/show'
            else
                erb :'plants/other_show'
            end
    end

    get '/plants/:id/edit' do
      redirect_if_not_logged_in
      @plant= current_user.plants.find_by(:id=> params[:id])
        if @plant 
          erb :'plants/edit'
           else
            flash[:plant_edit_fail] = "Sorry you can't edit that Plant."
            redirect to '/account'
        end
     end

    patch '/plants/:id' do
        redirect_if_not_logged_in
        @plant= current_user.plants.find_by(:id => params[:id])
          if @plant && !params[:plant].values.any?{|v| v.empty?}
            @plant.update(params[:plant])
            redirect to "/plants"
          else
            flash[:plant_edit_attempt] = "Sorry, please ensure all fields are filled out."
            redirect to "/plants/#{@plant.id}/edit"
          end
    end
    
    get '/plants/:id/delete' do
        redirect_if_not_logged_in
        @plant= current_user.plants.find_by(:id => params[:id]) 
            if @plant
              erb :'plants/delete'
            else 
              flash[:wrongful_plant_delete]= "Sorry You Can't Delete That Plant."
              redirect '/account'
            end
    end
    




    delete "/plants/:id" do
        redirect_if_not_logged_in
        @plant = current_user.plants.find_by(:id=> params[:id])
           if @plant
             Plant.destroy(params[:id])
             redirect to "/plants"
           else
             flash[:delete_attempt] = "You're not permitted to delete that Plant"
             redirect '/account' 
          end
     end
end