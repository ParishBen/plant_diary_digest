class TipController < ApplicationController
get '/tip/new' do
    @user = current_user
    if @user
        erb :tip
    else
       erb :failure
    end
  end
  post '/tips' do
    @tip = Tip.new(:plant_type=> params["plant_type"], :content=> params["content"])
    if !@tip.content.empty? && !@tip.plant_type.empty?
        @tip.user_id = current_user.id
        @tip.save
        redirect to '/account'
    else redirect to '/tip/failure'
    end
  end

  get '/tip/failure' do
    erb :tip_failure
  end
end