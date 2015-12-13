class StudentsController < ApplicationController
  before_action :logged_in?, only: [:index, :show]

	def edit
		@student = Student.find(params[:id])
	end

	def update
		@student = Student.find(params[:id])

		if @student.update_attributes(student_params)
			if !@student.activated
				StudentEmailConfirmation.account_activation(@student).deliver_now
				flash[:alert] = "Please check your email to activate your account."
				redirect_to login_path
			else
				log_in(@student)
				redirect_to @student
			end
		else
			if !current_student
				flash[:alert] = "Sorry, we could not sign you up!"
			else
				flash[:alert] = "Sorry, we could not edit your information!"
			end
		  	render "edit"
		end
	end

	def show
	  	@cohorts = Cohort.all
	  	@student = Student.find(params[:id])
	end

	def index
    	@student = Student.new
    	@students = Student.all
	end

  	def student_filter
	    cohort = Cohort.find(params[:cohort_id])
	    @students = Student.where(cohort_id: params[:cohort_id]).order(:name)
	    html = @students.map do |student|
	      render_to_string(partial: "students/student_index_div", locals: {:student => student})
	    end.join()
	    cohort_html = render_to_string(partial: "students/follow_cohort", locals: {:cohort => cohort})
	    render json: {html: html, cohort_html: cohort_html}
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

	def jeff_quotes
		
	end

	private

	def student_params
		params.require(:student).permit(:name, :email, :password, :password_confirmation, :twitter_handle, :github_handle, :linkedin_url, :cohort_id)
	end

	def auth_hash
    	request.env['omniauth.auth']
  	end

  	def logged_in?
	    if current_student.nil?
	      redirect_to login_path, :notice => "Please log in to view this page."
	    end
  	end

end

