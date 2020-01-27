class CommentsController < ApplicationController
	before_action :authenticate_user!
	before_action :find_user?, :set_feature, only: [:create]

	def create
  	@comment = @feature.comments.new(comment_params.merge(user_id: current_user.id))
  
  	respond_to do |format|
    	if @comment.save
      	format.js
       	if @feature.user_id and @user == current_user
      		recipient = @feature.user
     		elsif @feature.user == current_user
     			recipient = @user
     		else
     			recipient = nil
     		end

      	if recipient
   				CommentNotifierMailer.notifymail(recipient, @comment).deliver_now
      		Notification.create(recipient: recipient, user: current_user, feature: @feature, action: "commented")
     		end
	 		end
  	end
	end

	def destroy
		@comment = Comment.find(params[:id])
		@comment.destroy

		respond_to do |format| 
			format.js
		end
	end
	
	private
		def comment_params
			params.required(:comment).permit(:comment_name, :feature_id, :user_id)
		end

		def set_feature
			@feature = Feature.find(params[:feature_id])
		end
end