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

	def twitter_connect
		@student = current_student
		@student.update(provider: auth_hash.provider, uid: auth_hash.uid, token: auth_hash.credentials.token, secret: auth_hash.credentials.secret)
		redirect_to student_profile_path(@student)
	end

	private

	def student_params
		params.require(:student).permit(:email, :password, :password_confirmation)
	end

	def auth_hash
    	request.env['omniauth.auth']
    end

end