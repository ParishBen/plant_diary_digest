class UserController < ApplicationController
    get '/user/:id' do
        @user = User.find(params[:id])
        if @user == current_user
            erb :account
        else
            erb :other_account_view
        end
    end
end