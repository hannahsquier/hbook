class UserMailer < ApplicationMailer
	default from: Rails.application.secrets.mailer_email, subject: "Welcome to HBook!"

	def welcome(user)
		@user = user
		mail(to: @user.email)
	end
end
