class DocumentsController < ApplicationController
	before_action :authenticate_user!
	before_action :is_correct_user?
	before_action :set_feature, only: [:create, :show, :destroy]

	def create
		@document = @feature.documents.create(document_params)
		if @document.save!
			redirect_to user_project_path(@feature.project.user_id, @feature.project_id), notice: 'document Uploaded'
		end
	end

	def show
		@document = @feature.documents.find(params[:id])
	end

	def destroy
		@document = Document.find(params[:id])
		@document.destroy
		redirect_to user_project_path(@feature.project.user_id, @feature.project_id), notice: 'document Deleted'
	end
	
	private
		def document_params
			params.required(:document).permit(:document, :feature_id)
		end

		def set_feature
			@feature = Feature.find(params[:feature_id])
		end
end
