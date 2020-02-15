class ApplicationController < ActionController::Base
	protect_from_forgery with: :exception
	
	helper_method	 :current_user, :is_logged_in, :authenticate_user!, :is_correct_user?, :find_user?

	private
		def current_user
			User.find_by(id: session[:user_id])		 	
		end

	  def is_logged_in?
	  	if session[:user_id]
	  		@current_user = User.find(session[:user_id])
	  	else
	      flash[:alert] = "You must login with ur email id"
	  		redirect_to login_path
	  	end
	  end

	  def authenticate_user!
      redirect_to root_path unless is_logged_in?
    end

    def is_correct_user?
    	user_id = params[:user_id] || params[:id]
     	unless user_id.to_i == session[:user_id]
     		flash[:alert] = "You Cannot access other user's page!"
    		redirect_to users_path
  		end
    end

    def find_user?
    	user_id = params[:user_id] || params[:id]
    	@user = User.find(user_id)  		   	
    end

end
