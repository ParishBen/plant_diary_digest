class PlantController < ApplicationController

    get '/plants/new' do
        redirect_if_not_logged_in
          erb :'plants/new'
    end


    post '/plants' do
       @plant= Plant.new(:common_name=> params[:common_name], :plant_type=> params[:plant_type], :nickname=> params[:nickname], :user_id=> params[:user_id])
        if logged_in? && !params[:nickname].empty? && !params[:common_name].empty? && !params[:plant_type].empty?
            @plant.user_id = current_user.id
             @plant.save
              redirect to '/account'
        else 
            redirect '/plant_failure'
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
            elsif @plants = current_user.plants.find_by(:id=>@plant.id)  
                erb :'plants/show'
            else
                erb :'plants/other_show'
        end
    end

    get '/plants/:id/edit' do
        @plant= current_user.plants.find_by(:id=>@params[:id])
          redirect_if_not_logged_in
           if @plant 
            erb :'plants/edit'
           else
            redirect to '/account'
        end
     end

    patch '/plants/:id' do
        @plant= current_user.plants.find_by(:id=>@params[:id])
        if @plant && !params[:plant].values.any?{|v| v.empty?}
            @plant.update(params[:plant])
            redirect to "/plants"
        else
            erb :'plants/plant_failure'
        end
    end
    
    get '/plants/:id/delete' do
        @plant= current_user.plants.find_by(:id=>@params[:id])
          redirect_if_not_logged_in
            if @plant
              erb :'plants/delete'
            else redirect '/account'
           end
    end
    




    delete "/plants/:id" do
        @plant = current_user.plants.find_by(:id=>params[:id])
          redirect_if_not_logged_in
           if @plant
             Plant.destroy(params[:id])
             redirect to "/plants"
           else 
             redirect '/account' 
          end
     end
end