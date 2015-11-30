class SessionsController < ApplicationController

	def new
    
	end

	def create
		student = Student.find_by_email(params[:session][:email])
		if student && student.authenticate(params[:session][:password])
			if student.activated?
			    log_in(student)
			    redirect_to student_profile_path(student)
			else
				flash.now[:alert] = "Account not activated."
				redirect_to root_url
			end
		else
		  flash.now.alert = "Sorry, that's an invalid email/password combination!"
		  render "new"
		end
	end

	def destroy
		twitter_log_out
		github_log_out
		log_out
		redirect_to root_url
	end

	def destroy_twitter
		twitter_log_out
		redirect_to student_profile_path(current_student)
	end

	def destroy_github
    	github_log_out
    	redirect_to student_profile_path(@student)
  	end 

end
