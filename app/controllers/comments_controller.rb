class CommentsController < ApplicationController
	def index
		@comments = Comment.all
	end

	def new
		@comment = Comment.new
		@user = User.find(params[:user_id])
	end

	def create
		@user = current_user
		@comment = @user.comments.build(comment_params)

		if @comment.save
			flash[:success] = "Comment Posted!"
			redirect_back(fallback_location: root_path)
		else
			flash[:danger] = "Could not post comment: #{@comment.errors.full_messages}"
			redirect_back(fallback_location: root_path)
		end
	end


	private

	def comment_params
		params.require(:comment).permit(:content, :user_id, :post_id)
	end
end
