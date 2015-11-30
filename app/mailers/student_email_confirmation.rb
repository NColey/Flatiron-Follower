class StudentEmailConfirmation < ApplicationMailer

  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.student_email_confirmation.account_activation.subject
  #
  def account_activation(student)
    @student = student

    mail to: student.email, subject: "Flatiron Follower Account Activation"
  end

  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.student_email_confirmation.password_reset.subject
  #
  def password_reset
    @greeting = "Hi"

    mail to: "to@example.org"
  end
end
