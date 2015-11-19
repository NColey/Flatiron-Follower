class WelcomeController < ApplicationController

	def index
		@students = Student.all
	end

	def create
		@student = Student.find(params[:student][:id])
		redirect_to edit_student_path(@student)
	end
	
end
