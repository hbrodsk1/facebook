class UserMailer < ApplicationMailer
	default from: 'me@thisapp.com'

	def welcome_email(user)
		@user = user
		@url = 'http://localhost:3000/'
		mail(to: @user.email, subject: 'Welcome to Facebook!')
	end
end
