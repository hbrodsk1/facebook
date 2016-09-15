class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  
  before_filter :authenticate_user!

	def after_sign_up_path_for(resource)
    	user_path(@user)
  	end

  	def after_sign_in_path_for(resource)
  		user_path(@user)
  	end

  	def logged_in?
  	current_user ? true : false
  	end
end
