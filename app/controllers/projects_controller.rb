class ProjectsController < ApplicationController
	before_action :authenticate_user!
	before_action :is_correct_user?, except: [:show]
	before_action :find_user?, only: [:create, :index, :show]
	
	def search
		@user = User.find(params[:user_id])
		@project = Project.find(params[:id])
		@results = []



		unless params[:search].blank?
			@value = params[:search]
			regexp = Regexp.new(params[:search],"i")
			@project.features.includes(:user, :documents, :tasks).each do |feature|
				if @user == feature.user
					if feature.feature_name.match(regexp) || feature.ticket_id.to_s.match(regexp)
						@results<<feature
					end
				elsif @user == @project.user
					if feature.feature_name.match(regexp) || feature.ticket_id.to_s.match(regexp)
						@results<<feature
					end
				end
								
				respond_to do |format|
					format.js
				end
			end
		end
	end
	
	def index
  	@projects = @user.projects.all
	end
	
	def create
		@project = @user.projects.create(project_params)
		if @project.save
			redirect_to users_path, notice: 'Project Created' 
		else
			@project.errors.full_messages.each do |message|
       	flash[:alert] = message
     	end
			redirect_to users_path
		end
	end
		
	def show
		@project = Project.find(params[:id])
		@features = @project.features.includes(:documents, :tasks, { comments: :user } )
	end
	
	def destroy
		@project = Project.find(params[:id])
		@project.destroy
		redirect_to users_path, notice: 'Project Deleted'
	end

	private
		def project_params
			params.required(:project).permit(:project_name)
		end
end

