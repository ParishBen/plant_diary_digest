class LogController < ApplicationController
    get '/plant/log' do 
        @plant = Plant.find_by(:id=>params[:id])
        erb :plants_log
    end
end