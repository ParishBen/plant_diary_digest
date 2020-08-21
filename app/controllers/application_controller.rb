require_relative '../../config/environment'
class ApplicationController < Sinatra::Base
  configure do
    set :views, "app/views"
    set :public, "public/sytlesheets/"
    enable :sessions 
    set :session_secret, ENV['SESSION_SECRET']
  end
 
  get '/' do
    erb :'users/welcome'
  end
  
  get '/login' do
    erb :'users/login'
  end
  
  get '/signup' do
    erb :'users/signup'
  end

  post '/signup' do
    user= User.new(:name=> params[:name], :username=> params[:username], :password=> params[:password], :email=> params[:email])
    
    if !params[:name].empty?  && !params[:username].empty? && !params[:password].empty? && !params[:email].empty? && !User.find_by(:username=>params[:username]) && !User.find_by(:email=>params[:email])
      user.save
      redirect '/login' 
    elsif 
    User.find_by(:username=>params[:username])
      erb :'users/username_error'
    elsif  User.find_by(:email=>params[:email])
        erb :'users/email_error'
      else
    redirect '/failure'
    end
   end
 
  
  get '/failure' do
    erb :'users/failure'
  end

  post '/login' do
    @user= User.find_by(:username=> params[:username])
    if @user && @user.authenticate(params[:password])
      session[:user_id] = @user.id
      redirect to '/account'
    else
      redirect '/failure'
    end
  end
  
  get '/account' do
    if logged_in?
    erb :'users/account'
    else redirect to '/'
    end
  end
  
  get "/logout" do
		session.clear
		redirect "/"
	end
 
  get "/home" do
    @users = User.all
    @tips = Tip.all
    
    erb :'users/home'
    
  end

  helpers do
		def logged_in?
			!!session[:user_id]
		end

		def current_user
			User.find(session[:user_id])
    end
  end

  

end
#Proc.new { File.join(root, "../views/") }