class WelcomeController < ApplicationController

	def index
		@students = Student.all
	end

	def create
		binding.pry
		@student = Student.find(params[:student][:id])
		if @student.password_digest != nil
			flash[:alert] = "Sorry this user already has an account! Please log in below or go back to sign up."
      		redirect_to login_path(@student)
      	else
			redirect_to edit_student_path(@student)
		end
	end
	
end
