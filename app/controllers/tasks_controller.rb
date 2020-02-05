class TasksController < ApplicationController
	before_action :authenticate_user!
	before_action :is_correct_user?, except: [:create, :destroy, :update_task]
	before_action :set_feature, only: [:create, :destroy]


	def create
		@task = @feature.tasks.create(task_params)
		if @task.save
			redirect_to user_project_path(@feature.project.user_id, @feature.project_id), notice: 'Task Created'
		else
			@task.errors.full_messages.each do |message|
       	flash[:alert] = message
     	end
			redirect_to user_project_path(@feature.project.user_id, @feature.project_id)
		end
	end

	def destroy
		@task = Task.find(params[:id])
		@task.destroy
		redirect_to user_project_path(@feature.project.user_id, @feature.project_id), notice: 'Task Deleted'
	end

	def update_task
  	@task = Task.find(params[:id])
		@task.update_attributes(task_completion: params[:task_completion])
	end

	private
		def task_params
			params.required(:task).permit(:task_name, :feature_id)
		end

		def set_feature
			@feature = Feature.find(params[:feature_id])
		end
end