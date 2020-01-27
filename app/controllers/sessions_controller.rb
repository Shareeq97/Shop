class SessionsController < ApplicationController
  include AuthHelper
  
  def new
    @login_url = get_login_url
  end

  def create
  	user = User.find_by_email(params[:email])
    if user
      if user.authenticate(params[:password]) 
        session[:user_id] = user.id
        redirect_to users_path
      else 
        flash[:alert] = "Invalid User Name or Password"
        redirect_to login_path
      end
    else
      flash[:alert] = "User Doesn't Exists"
      redirect_to login_path
    end
  end

  def destroy
  	session[:user_id] = nil
    flash[:alert] = "Logged Out!"
  	redirect_to login_path
  end
end
