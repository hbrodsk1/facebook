class PostsController < ApplicationController

	def index
		@posts = Post.all
		@user = User.find(params[:user_id])
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
			flash[:notice] = "Post could not be submitted"
			redirect_to users_path
		end
	end

	private

	def post_params
		params.require(:post).permit(:content)
	end
end
