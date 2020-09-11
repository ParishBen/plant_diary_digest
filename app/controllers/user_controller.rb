class UserController < ApplicationController
    
    get '/signup' do
        if !logged_in?
            erb :'users/signup'
        else 
            redirect to '/account'
        end
      end

    get '/login' do
        if !logged_in?
           erb :'users/login'
        else
           redirect to '/account'
        end
      end
    
      post '/signup' do
        user= User.new(:name => params[:name], :username => params[:username], :password => params[:password], :email => params[:email])
        
         if !params[:name].empty?  && !params[:username].empty? && !params[:password].empty? && !params[:email].empty? && !User.find_by(:username=>params[:username]) && !User.find_by(:email=>params[:email])
          user.save
            session[:user_id] = user.id
            redirect to '/account'
              elsif User.find_by(:username => params[:username])
                erb :'users/username_error'
              elsif  User.find_by(:email => params[:email])
                erb :'users/email_error'
         else
           redirect '/failure'
         end
       end
     
      
      get '/failure' do
        erb :'users/failure'
      end
    
      post '/login' do
        @user= User.find_by(:username => params[:username])
          if @user && @user.authenticate(params[:password])
            session[:user_id] = @user.id
            redirect to '/account'
          else
            redirect '/failure'
         end
      end
      
      get "/logout" do
            session.clear
            redirect "/"
       end

      get '/account' do
        redirect_if_not_logged_in
            erb :'users/account'
      end
    
      get '/users/:id' do
        @user = User.find_by(:id => params[:id])
          if !logged_in? || current_user.id != @user.id
            erb :'users/other_account_view'
          elsif @user == current_user
            erb :'users/account'
          end
       end
    
end