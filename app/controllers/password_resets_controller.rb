class PasswordResetsController < ApplicationController
  before_action :find_student,   only: [:edit, :update]
  before_action :confirm_student, only: [:edit, :update]
  before_action :check_password_digest_expiration, only: [:edit,:update]

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
  		render 'edit'
  	end
  end

  def edit
  end

  def update
    if params[:student][:password].empty?
      flash.now[:alert] = "Password field cannot be empty."
      render 'edit'
    elsif @student.update_attributes(student_params)
      log_in(@student)
      flash.now[:alert] = "Password has been reset."
      redirect_to @student
    else
      render 'edit'
    end
  end

  private

  def student_params
    params.require(:student).permit(:password, :password_confirmation)
  end

  def find_student
    @student = Student.find_by(email: params[:email])
  end

  def confirm_student
    unless (@student && @student.activated? && @student.authenticated?(:password_reset, params[:id]))
      redirect_to root_url
    end
  end

  def check_password_digest_expiration
    if @student.password_reset_expired?
      flash.now[:alert] = "Your password reset link has expired. Please try again."
      redirect_to new_password_reset_url
    end
  end
end
