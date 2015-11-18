module Adapters
  class GithubConnection
    include HTTParty

    attr_reader :connection 

    def initialize
      @connection = self.class
    end

    def follow(auth_token, cohort_id)
      students = Student.where(cohort_id: cohort_id)
      students.each do |student|
        username = student.github_handle
        options = {
          headers:{
            "User-Agent" => "Flatiron Follower",
            "Authorization" => "token #{auth_token}"
          },
          body:{}
        } 
        connection.put("https://api.github.com/user/following/#{username}", options)
      end     
    end

    def unfollow(auth_token, cohort_id)
     students = Student.where(cohort_id: cohort_id)
      students.each do |student|
        username = student.github_handle
        options = {
          headers:{
            "User-Agent" => "Flatiron Follower",
            "Authorization" => "token #{auth_token}"
          },
          body:{}
        } 
        connection.delete("https://api.github.com/user/following/#{username}", options)
      end     
    end

  end

end

