class PlantController < ApplicationController

    get '/plant/new' do
        if !logged_in?
            redirect '/'
        else
        erb :plant
    end
end

    post '/plants' do
       @plant= Plant.new(:common_name=> params[:common_name], :plant_type=> params[:plant_type], :nickname=> params[:nickname], :user_id=> params[:user_id])
    if !params[:nickname].empty? && !params[:common_name].empty? && !params[:plant_type].empty?
        @plant.user_id = current_user.id
        @plant.save
        redirect to '/account'
    else 
        redirect '/plant_failure'
         end 
        end

    get '/plant_failure' do
    erb :plant_failure
    end
    
    get '/plants' do
        if logged_in?
        erb :account
        else redirect '/'
    end
end

    get '/plant/:id' do 
        if !logged_in?
            @plant = Plant.find(params[:id])
            erb :other_show
        elsif
        @plant = Plant.find(params[:id])
        @plants= current_user.plants
        if @plants.find_by(:id=>@plant.id)
        erb :plant_show
        else
            erb :other_show
        end
    end
end
    get '/plant/:id/edit' do
    if
        !logged_in?
            redirect to '/'
    elsif
        @plant = Plant.find(params[:id])
        @plants = current_user.plants
        if @plants.find_by(:id=>@plant.id)
            erb :plant_edit
            else
                redirect to '/account'
            end
        end
    end

    patch '/plant/:id' do
        @plant = Plant.find(params[:id])
        if !params[:plant].values.any?{|v| v.empty?}
        @plant.update(params[:plant])
        redirect to "/plants"
    else
        erb :plant_failure
    end
end
    
    get '/plant/:id/delete' do
        if !logged_in?
            redirect to '/'
        elsif
        @plant = Plant.find(params[:id])
        @plants = current_user.plants
        if @plants.find_by(:id=>@plant.id)
        erb :delete_plant 
        else redirect '/account'
     end
    end
    
end



    delete "/plant/:id" do
        Plant.destroy(params[:id])
        redirect to "/plants"
      end
end