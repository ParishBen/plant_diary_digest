class UserController < ApplicationController
    get '/users/:id' do
        if !logged_in?
            @user = User.find(params[:id])
            erb :'users/other_account_view'
        elsif
        @user = User.find(params[:id])
        if @user == current_user
            erb :'users/account'
        else
            erb :'users/other_account_view'
        end
      end
    end
end