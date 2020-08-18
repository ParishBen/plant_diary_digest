class PlantController < ApplicationController

    get '/plant/new' do
        erb :plant
    end
    
    post '/plants' do
       @plant= Plant.new(:common_name=> params[:common_name], :plant_type=> params[:plant_type], :nickname=> params[:nickname], :user_id=> params[:user_id])
    if !params[:nickname].empty?
        @plant.user_id = current_user.id
        @plant.save
        erb :account
    else 
        redirect '/plant_failure'
         end 
        end

    get '/plant_failure' do
    erb :plant_failure
    end
    
    get '/plants' do
        erb :account
    end

    get '/plant/:id' do 
        @plant = Plant.find_by(:id=>params[:id])
        
        erb :plant_show
    end

    get '/plant/:id/edit' do
        @plant = Plant.find(params[:id])
        erb :plant_edit
    end

    patch '/plant/:id' do
        @plant = Plant.find(params[:id])
        @plant.update(params[:plant])
        redirect to "/plants"
    end
    
    get '/plant/:id/delete' do
        @plant = Plant.find(params[:id])
        erb :delete_plant
        
    end
    delete "/plant/:id" do
        Plant.destroy(params[:id])
        
        redirect to "/plants"
      end
end