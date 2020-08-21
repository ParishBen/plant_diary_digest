class TipController < ApplicationController
get '/tips/new' do
    @user = current_user
    if @user
        erb :'tips/tip'
    else
       erb :'users/failure'
    end
  end
  post '/tips' do
    @tip = Tip.new(:plant_type=> params["plant_type"], :content=> params["content"])
    if !@tip.content.empty? && !@tip.plant_type.empty?
        @tip.user_id = current_user.id
        @tip.save
        redirect to '/account'
    else 
        redirect to '/tips/failure'
    end
  end

  get '/tips/failure' do
    erb :'tips/tip_failure'
  end

  get '/tips/:id/edit' do
    if !logged_in?
      erb :'users/failure'
    elsif
    @tip = Tip.find(params[:id])
    @tips = current_user.tips
    if  !@tips.find_by(:id=>@tip.id)
      redirect '/account'
    else
     
      erb :'tips/tip_edit'
    end
   end
  end

  patch '/tips/:id' do
    @tip = Tip.find(params[:id])
    if !params[:tip].values.any?{|v| v.empty?} 
    @tip.update(params[:tip])
    redirect to '/account'
  
    else erb :'tips/tip_failure'
  end
end



  get '/tips/:id/delete' do
    @tip = Tip.find(params[:id])
    @tips = current_user.tips
    if  @tips.find_by(:id=>@tip.id)
        erb :'tips/tip_delete'
         
    elsif logged_in? 
            redirect to '/account'
    else
        erb :'users/failure'
     end
    end

    delete '/tips/:id' do
        Tip.destroy(params[:id])
        redirect to '/account'
    end
end