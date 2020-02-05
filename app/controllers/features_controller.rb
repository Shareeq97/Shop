class FeaturesController < ApplicationController
	before_action :authenticate_user!
	before_action :is_correct_user?, except: [:update_member, :update_status]
	before_action :set_project, only: [:create, :destroy]

	def create		
		@feature = @project.features.create(feature_params)
		if @feature.save
			redirect_to user_project_path(@project.user_id, @project.id), notice: 'Feature Created'
		else
			@feature.errors.full_messages.each do |message|
       	flash[:alert] = message
     	end
			redirect_to user_project_path(@project.user_id, @project.id)
		end
	end

	def destroy
		@feature = Feature.find(params[:id])
		@feature.destroy
		redirect_to  user_project_path(@project.user_id, @project.id), notice: 'Feature Deleted'
	end

	def update_member
		@feature = Feature.find(params[:id])
		@feature.update_attributes(user_id: params[:member_id])
	end

	def update_status
		@feature = Feature.find(params[:id])
		@feature.update_attributes(feature_status: params[:feature_status])

		if @feature.user_id
		recipients =	[@feature.project.user,@feature.user] 
		else 
		recipients =	[@feature.project.user]
		end
		recipients.each do |recipient|
			FeatureStatusNotifierMailer.notify_mail(recipient, @feature).deliver_now
		end

		if @feature.user_id and @feature.project.user == current_user
      recipient = @feature.user
    elsif @feature.user == current_user
 			recipient = @feature.project.user
   	else
   		recipient = nil
    end
   	if recipient
   		Notification.create!(recipient: recipient, user: current_user, feature: @feature, action: "changed status")
 		end
	end
	
	private
		def feature_params
			params.required(:feature).permit(:category_name, :feature_name, :feature_description, :project_id)
		end

		def set_project
			@project = Project.find(params[:project_id])
		end
end
