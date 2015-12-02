class PasswordResetsController < ApplicationController
  before_action :find_student,   only: [:edit, :update]
  before_action :confirm_student, only: [:edit, :update]

  def new
  end

  def create
  	@student = Student.find_by(email: params[:password_reset][:email].downcase)
  	if @student
  		@student.create_password_reset_digest
  		@student.send_password_reset_email
  		flash.now[:alert] = "Check your email for instrcutions to reset your password"
  		redirect_to login_path
  	else
  		flash.now[:alert] = "Email address not found"
  		redirect_to root_url
  	end
  end

  def edit
  end

  private

  def find_student
    @student = Student.find_by(email: params[:email])
  end

  def confirm_student
    unless (@student && @student.activated? && @student.authenticated?(:password_reset, params[:id]))
      redirect_to root_url
    end
  end
end
