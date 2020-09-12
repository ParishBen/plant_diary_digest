class TipController < ApplicationController
  get '/tips/new' do
    redirect_if_not_logged_in
    if @user = current_user
        erb :'tips/new'
    else
        erb :'users/failure'
     end
  end
  
  post '/tips' do
   redirect_if_not_logged_in 
   @tip = Tip.new(:plant_type=> params["plant_type"], :content=> params["content"])    
        if !@tip.content.empty? && !@tip.plant_type.empty?
          @tip.user_id = current_user.id
          @tip.save
          redirect to '/account'
        else 
          flash[:new_tip_error] = "Sorry, ensure all fields are filled out"
          redirect to '/tips/new'
       end
   end

  get '/tips/failure' do
    erb :'tips/tip_failure'
  end

  get '/tips/:id/edit' do
    redirect_if_not_logged_in
    @tip= current_user.tips.find_by(:id=> params[:id])
      if @tip
        erb :'tips/edit'
      else 
        flash[:wrongful_tip_edit] = "Sorry, you're not permitted to edit that."
        redirect '/account'
      end
    end
     
     
  

  patch '/tips/:id' do
    redirect_if_not_logged_in
    @tip= current_user.tips.find_by(:id=> params[:id])
      if @tip && !params[:tip].values.any?{|v| v.empty?} 
         @tip.update(params[:tip])
         redirect to '/account'
      else 
        flash[:tip_edit_fail] = "Sorry, please ensure all fields are filled out!"
        redirect to "/tips/#{@tip.id}/edit"
     end
  end



  get '/tips/:id/delete' do
    redirect_if_not_logged_in
    @tip= current_user.tips.find_by(:id=> params[:id])     
       if @tip
          erb :'tips/delete'
       else
          flash[:wrongful_tip_delete] = "You can not delete that Tip."
          redirect to '/account'
       end
   end

  delete '/tips/:id' do
    redirect_if_not_logged_in
    @tip= current_user.tips.find_by(:id=> params[:id])
       if @tip
         Tip.destroy(params[:id])
         redirect to '/account'
       elsif !@tip
        flash[:delete_attempt] = "You're not permitted to delete that Tip"
        redirect '/account'
      end
    end
end