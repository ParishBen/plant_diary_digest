require_relative '../../config/environment'
class ApplicationController < Sinatra::Base
  configure do
    set :views, "app/views/"
    enable :sessions unless test?
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
    if !(user.name && user.username && user.password).empty?
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
    user= User.find_by(:username=> params[:username])
    if user && user.authenticate(params[:password])
      redirect '/account'
    else
      redirect '/failure'
    end
  end
  
  get '/account' do
    "You're in your account!"
  end
end
#Proc.new { File.join(root, "../views/") }