class LikesController < ApplicationController

  def index
  	@post = Post.find(params[:post_id])
  	@likes = @post.likes
  end

  def create
  	@post = Post.find(params[:post_id])

  	@like = Like.new(user_id: current_user.id, post_id: @post.id)
  	if @like.save
  		flash[:success] = "Post Liked!"
  		redirect_back(fallback_location: root_path)
  	else
  		flash[:danger] = "Couldn't like post"
  		redirect_back(fallback_location: root_path)
  	end
  end


  def destroy
  	@like = Like.find(params[:id])
  	@like.destroy
  	flash[:success] = "Post unliked"
  	redirect_back(fallback_location: root_path)
  end
end
