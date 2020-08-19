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
    else 
        redirect to '/tip/failure'
    end
  end

  get '/tip/failure' do
    erb :tip_failure
  end

  get '/tip/:id/edit' do
    @tip = Tip.find(params[:id])
    @tips = current_user.tips
    if  @tips.find_by(:id=>@tip.id)
         erb :tip_edit
    elsif logged_in? 
            redirect to '/account'
    else
        erb :failure
   end
  end

  patch '/tip/:id' do
    @tip = Tip.find(params[:id])
    @tip.update(params[:tip])
    redirect to '/account'
  end

  get '/tip/:id/delete' do
    @tip = Tip.find(params[:id])
    @tips = current_user.tips
    if  @tips.find_by(:id=>@tip.id)
        erb :tip_delete
         
    elsif logged_in? 
            redirect to '/account'
    else
        erb :failure
     end
    end

    delete '/tip/:id' do
        Tip.destroy(params[:id])
        redirect to '/account'
    end
end