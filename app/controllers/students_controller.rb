class StudentsController < ApplicationController

	def edit
		@student = Student.find(params[:id])
	end

	def update
		@student = Student.find(params[:id])

		if @student.update_attributes(student_params)
				log_in(@student)
				redirect_to @student
		else
			if !current_student
				flash.now[:alert] = "Sorry, we could not sign you up!"
			else
				flash.now[:alert] = "Sorry, we could not edit your information!"
			end
		  	render "edit"
		end
	end

	def show
	  	@cohorts = Cohort.all
	  	@student = Student.find(params[:id])
	end

  	def twitter_connect
	  	@student = current_student
	  	@student.update(provider: auth_hash.provider, uid: auth_hash.uid, token: auth_hash.credentials.token, secret: auth_hash.credentials.secret)
	  	redirect_to student_profile_path(@student)
  	end

 	def github_connect
	  	@student = current_student
	  	@student.update(auth_hash["provider"]=>auth_hash["credentials"]["token"])
	  	redirect_to student_profile_path(@student)
	end 

	def destroy_github
		@student = current_student
		@student.github = nil
		@student.save
		redirect_to student_profile_path(@student)
	end

	private

	def student_params
		params.require(:student).permit(:email, :password, :password_confirmation, :twitter_handle, :github_handle)
	end

	def auth_hash
    	request.env['omniauth.auth']
  	end
end

