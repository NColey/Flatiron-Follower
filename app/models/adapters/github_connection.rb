module Adapters
  class GithubConnection
    include HTTParty

    attr_reader :connection 

    def initialize
      @connection = self.class
    end

    def follow(token, cohort_id)
      students = Student.where(cohort_id: cohort_id)
      students.each do |student|
        username = student.github_handle 
        connection.put("https://api.github.com/user/following/#{username}?access_token=#{token}", :body =>{})
      end     
    end

  end

end