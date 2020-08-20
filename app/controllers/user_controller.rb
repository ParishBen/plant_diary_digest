class UserController < ApplicationController
    get '/user/:id' do
        if !logged_in?
            @user = User.find(params[:id])
            erb :other_account_view
        elsif
        @user = User.find(params[:id])
        if @user == current_user
            erb :account
        else
            erb :other_account_view
        end
      end
    end
end