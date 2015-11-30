class AccountActivationsController < ApplicationController
	def edit
		student = Student.find_by(email: params[:email])
		if student && !student.activated? && student.authenticated?(:activation, params[:id])
			student.update_attribute(:activated, true)
			student.update_attribute(:activated_at, Time.zone.now)
			log_in(student)
			flash[:alert] = "Account Activated!"
			redirect_to(student)
		else
			flash[:alert] = "Invalid activation link"
			redirect_to root_url
		end
	end
end
