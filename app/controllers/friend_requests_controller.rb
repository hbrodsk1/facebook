class FriendRequestsController < ApplicationController
	before_action :set_friend_request, except: [:index, :create]

	def index
		@incoming = FriendRequest.where(friend: current_user)
		@outgoing = current_user.friend_requests
	end

	def create
		@user = User.find(current_user)
		@friend = User.find(params[:friend_id])
		@friend_request = current_user.friend_requests.new(friend_id: @friend.id)

		if @friend_request.save
			flash[:success] = "Friend request sent!"
			redirect_to users_path
		else
			flash[:danger] = "Unable to request friend"
			redirect_to users_path
		end
	end

	def update
		friend_email = User.find(@friend_request.friend_id).email
		
		@friend_request = FriendRequest.find_by_user_id_and_friend_id(params[:friend_id], params[:id])
		if @friend_request.accept
			flash[:success] = "You and #{friend_email} are now friends!"
			redirect_to user_path(current_user)
		end

	end

	def destroy
		if @friend_request.destroy
			flash[:danger] = "Request Declined"
			redirect_to user_path(current_user)
		end
	end


	private

	def set_friend_request
		@friend_request = FriendRequest.find_by_user_id_and_friend_id(params[:friend_id], params[:id])
	end
end
