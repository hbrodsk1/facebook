class PostsController < ApplicationController

	def index
		@posts = Post.all
		@user = User.find(params[:user_id])
		@comment = Comment.new
	end

	def new
		@post = Post.new
		@user = User.find(params[:user_id])
	end

	def create
		@post = current_user.posts.build(post_params)
		if @post.save
			flash[:success] = "Posted!"
			redirect_to user_path(current_user)
		else
			flash[:danger] = "Post could not be submitted: #{@post.errors.full_messages}"
			redirect_to user_path(current_user)
		end
	end

	private

	def post_params
		params.require(:post).permit(:content)
	end
end
