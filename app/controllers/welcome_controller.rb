class WelcomeController < ApplicationController

	def index
		@students = Student.all
	end

	def create
		@student = Student.find(params[:student][:id])
		if @student.password_digest != nil
			flash.now[:alert] = "Sorry this user already has an account!"
      		redirect_to login_path(@student)
      	else
			redirect_to edit_student_path(@student)
		end
	end
	
end
