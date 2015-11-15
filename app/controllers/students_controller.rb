class StudentsController < ApplicationController

	def new	
		@student = Student.find_by_name(params[:name])

	end

end
