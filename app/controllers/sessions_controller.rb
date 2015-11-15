class SessionsController < ApplicationController

	def new
    
	end

	def create
		student = Student.find_by_email(params[:email])
		if student && student.authenticate(params[:password])
		    log_in(student)
		    redirect_to root_url
		else
		  flash.now.alert = "Sorry, that's an invalid email/password combination!"
		  render "new"
		end
	end

	def update
		student = session[:student_id]
		params[:provider] = auth_hash.token
	end

	def destroy
		log_out
		redirect_to root_url
	end

	private 
	def auth_hash
		request.env['omniauth.auth']
	end

end
