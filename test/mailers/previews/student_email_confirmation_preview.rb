# Preview all emails at http://localhost:3000/rails/mailers/student_email_confirmation
class StudentEmailConfirmationPreview < ActionMailer::Preview

  # Preview this email at
  # http://localhost:3000/rails/mailers/student_email_confirmation/account_activation
  def account_activation
    student = Student.find(25)
    student.activation_token = Student.new_token
    StudentEmailConfirmation.account_activation(student)
  end

  # Preview this email at
  # http://localhost:3000/rails/mailers/student_email_confirmation/password_reset
  def password_reset
    StudentEmailConfirmation.password_reset
  end

end