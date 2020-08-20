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
    if !logged_in?
      erb :failure
    elsif
    @tip = Tip.find(params[:id])
    @tips = current_user.tips
    if  !@tips.find_by(:id=>@tip.id)
      redirect '/account'
    else
     
      erb :tip_edit
    end
   end
  end

  patch '/tip/:id' do
    @tip = Tip.find(params[:id])
    if !params[:tip].values.any?{|v| v.empty?} 
    @tip.update(params[:tip])
    redirect to '/account'
  
    else erb :tip_failure
  end
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