require_relative '../../config/environment'
class ApplicationController < Sinatra::Base
  configure do
    set :views, "app/views/"
    enable :sessions unless test?
    set :session_secret, "secret"
  end
  get '/' do
    "YES!"
  end
  get '/crazy' do
    erb :index
  end
  get '/happy' do
  erb :indexes
  end
end
#Proc.new { File.join(root, "../views/") }