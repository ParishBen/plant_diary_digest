class PlantController < ApplicationController

    get '/plants/new' do
        if !logged_in?
            redirect '/'
        else
        erb :'plants/plant'
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
    erb :'plants/plant_failure'
    end
    
    get '/plants' do
        if logged_in?
        erb :'users/account'
        else redirect '/'
    end
end

    get '/plants/:id' do 
        if !logged_in?
            @plant = Plant.find(params[:id])
            erb :'plants/other_show'
        elsif
        @plant = Plant.find(params[:id])
        @plants= current_user.plants
        if @plants.find_by(:id=>@plant.id)
        erb :'plants/plant_show'
        else
            erb :'plants/other_show'
        end
    end
end
    get '/plants/:id/edit' do
    if
        !logged_in?
            redirect to '/'
    elsif
        @plant = Plant.find(params[:id])
        @plants = current_user.plants
        if @plants.find_by(:id=>@plant.id)
            erb :'plants/plant_edit'
            else
                redirect to '/account'
            end
        end
    end

    patch '/plants/:id' do
        @plant = Plant.find(params[:id])
        if !params[:plant].values.any?{|v| v.empty?}
        @plant.update(params[:plant])
        redirect to "/plants"
    else
        erb :'plants/plant_failure'
    end
end
    
    get '/plants/:id/delete' do
        if !logged_in?
            redirect to '/'
        elsif
        @plant = Plant.find(params[:id])
        @plants = current_user.plants
        if @plants.find_by(:id=>@plant.id)
        erb :'plants/delete_plant'
        else redirect '/account'
     end
    end
    
end



    delete "/plants/:id" do
        Plant.destroy(params[:id])
        redirect to "/plants"
      end
end