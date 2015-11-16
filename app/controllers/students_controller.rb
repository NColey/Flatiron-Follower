class StudentsController < ApplicationController
	def new

	end

  def connect
    @student = Student.find_by(id:session[:student_id])
    @student.update(auth_hash["provider"]=>auth_hash["credentials"]["token"])
    redirect_to student_profile_path(@student)

  end

private 
  def auth_hash
    request.env['omniauth.auth']
  end

end
