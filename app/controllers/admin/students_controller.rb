class Admin::StudentsController < ApplicationController
  before_action :authorized?

  def new
    @student = Student.new
  end

  def create
    @student = Student.new(student_params)
    @student.save(validate: false)
    redirect_to cohort_path(@student.cohort)
  end

  def edit
    @student = Student.find(params[:id])
  end

  def update
    @student = Student.find(params[:id])
    @student.update_columns(student_params)
    redirect_to cohort_path(@student.cohort)
  end

private 
  def student_params
    params.require(:student).permit(:name, :email, :cohort_id, :twitter_handle, :github_handle)
  end

  def authorized?
    if !(logged_in? && current_student.try(:admin?))
      redirect_to login_path, :notice => "Sorry, you don't have access to this page."
    end
  end

end
