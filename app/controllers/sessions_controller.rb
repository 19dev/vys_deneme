class SessionsController < ApplicationController
  def new
  end

def create
    user = User.find_by_username(params[:username])
    if user && user.authenticate(params[:password])
      session[:user_id] = user.id
      render "a/deneme"
    else
      flash.now.alert = "Invalid username or password"
      redirect_to root_path
    end
  end
end
