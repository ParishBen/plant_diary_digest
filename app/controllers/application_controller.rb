require_relative '../../config/environment'
class ApplicationController < Sinatra::Base
  configure do
    set :views, "app/views/"
    enable :sessions 
    set :session_secret, "secret"
  end
 
  get '/' do
    erb :welcome
  end
  
  get '/login' do
    erb :login
  end
  
  get '/signup' do
    erb :signup
  end

  post '/signup' do
    user= User.new(:name=> params[:name], :username=> params[:username], :password=> params[:password])
    if !params[:name].empty?  && !params[:username].empty? && !params[:password].empty?
      user.save
      redirect '/login' 
  else 
    redirect '/failure'
  end
end
  
  get '/failure' do
    erb :failure
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
    erb :account
  end
  
  get "/logout" do
		session.clear
		redirect "/"
	end
 
  get "/home" do
    @users = User.all
    @tips = Tip.all
    
    erb :home
    
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