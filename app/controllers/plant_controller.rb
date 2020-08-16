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

end