class UsersController < ApplicationController

	def index
		@users = User.all
	end

	def show
		@user = User.find(params[:id])
		@posts = Post.all
		@post = @user.posts.build
		@comment = @post.comments.build
	end

end
