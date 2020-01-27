class UsersController < ApplicationController
	before_action :authenticate_user!, except: [:new, :create]	
	before_action :is_correct_user?, except: [:index, :new, :create]
	before_action :find_user?, only: [:show, :edit, :update, :destroy ]

	def index
		@project = current_user.projects.build
	end

	def new
		@user=User.new
	end

	def create
		@user = User.new(user_params)
		if @user.save
			UserMailer.with(user: @user).welcome_email(@user).deliver_now
			redirect_to signup_path, notice: "User Sign Up Successfull. Now Login"
		else
			render "new"
		end
	end

	def edit		
	end

	def show
	end

	def update
    if @user.update(user_params)
      redirect_to users_path, notice: 'User was successfully updated.'
    else
      render "edit"
    end
  end

  def destroy
  	@user.destroy
  	redirect_to users_path, alert: 'User was Successfully deleted'
  end

  private
  	def user_params
  		params.require(:user).permit(:first_name,:last_name,:email,:phone_number,:password,:password_confirmation)	  		
  	end
end
