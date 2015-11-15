class StudentsController < ApplicationController

	def edit
		@student = Student.find(params[:id])
	end

	def update
		@student = Student.find(params[:id])
		if @student.update_attributes(student_params)
			redirect_to @student
		else
			flash.now.alert = "Sorry, we could not sign you up!"
		  	render "edit"
		end
	end

	private

	def student_params
		params.require(:student).permit(:email, :password, :password_confirmation)
	end

end
