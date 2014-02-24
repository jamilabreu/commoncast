class UserMailer < ActionMailer::Base
  default from: "from@example.com"

	def temporary_password(user, password)
		@user = user
		@password = password
		@url  = 'http://example.com/login'
		headers["X-Commoncast"] = "temp-pwd"
		mail to: @user.email, subject: 'Welcome to My Awesome Site'
	end
end
