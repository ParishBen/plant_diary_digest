require_relative '../../config/environment'
class ApplicationController < Sinatra::Base
  configure do
    set :views, "app/views"
    set :public_folder, "public/stylesheets"
    enable :sessions 
    set :session_secret, ENV['SESSION_SECRET']
    register Sinatra::Flash
  end
 
  get '/' do
    if !logged_in?
       erb :'users/welcome'
    else 
       redirect to '/account'
    end
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

    def redirect_if_not_logged_in
        if !logged_in?
          redirect to '/'
        end
     end
  end
end
