class TipController < ApplicationController
  get '/tips/new' do
    @user = current_user
      if @user
        erb :'tips/new'
      else
        erb :'users/failure'
     end
  end
  
  post '/tips' do
    @tip = Tip.new(:plant_type=> params["plant_type"], :content=> params["content"])    
      redirect_if_not_logged_in
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
    @tip= current_user.tips.find_by(:id=> params[:id])
       redirect_if_not_logged_in
         if @tip
            erb :'tips/edit'
         else 
            redirect '/account'
        end
    end
     
     
  

  patch '/tips/:id' do
    @tip= current_user.tips.find_by(:id=> params[:id])
      if @tip && !params[:tip].values.any?{|v| v.empty?} 
         @tip.update(params[:tip])
         redirect to '/account'
      else 
        erb :'tips/tip_failure'
     end
  end



  get '/tips/:id/delete' do
    @tip= current_user.tips.find_by(:id=> params[:id])     
      redirect_if_not_logged_in
        if @tip
          erb :'tips/delete'
        else
          redirect to '/account'
       end
   end

  delete '/tips/:id' do
    @tip= current_user.tips.find_by(:id=> params[:id])
      redirect_if_not_logged_in
       if @tip
         Tip.destroy(params[:id])
         redirect to '/account'
       elsif !@tip
        erb :'tips/tip_failure'
      end
    end
end