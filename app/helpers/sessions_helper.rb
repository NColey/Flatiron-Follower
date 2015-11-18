module SessionsHelper
	def log_in(student)
        session[:student_id] = student.id
    end

    def log_out
        @student = Student.find_by(id: session[:student_id])
        @student.update(provider: nil, uid: nil, token: nil, secret: nil, github: nil)
        session.delete(:student_id)
        @current_student = nil
    end

    def current_student
        @current_student ||= Student.find_by(id: session[:student_id])
    end

    def logged_in?
        !current_student.nil?
    end

    def logged_in_with_twitter?
        current_student.uid != nil
    end

    def twitter_log_out
        @student = Student.find_by(id: session[:student_id])
        @student.update(provider: nil, uid: nil, token: nil, secret: nil)
    end

end
