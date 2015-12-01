class Admin::StudentsController < ApplicationController

  def new
    @student = Student.new
  end

  def create
    @student = Student.new(student_params)
    @student.save
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

end
