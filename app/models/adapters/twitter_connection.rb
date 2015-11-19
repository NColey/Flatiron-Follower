module Adapters
  class TwitterConnection
    include HTTParty

    attr_reader :connection 

    def initialize
      @connection = self.class
    end

    def follow(cohort_id)
      students = Student.where(cohort_id: cohort_id)
      students.each do |student|
        username = student.twitter_handle
        # options = {
        #   headers:{
        #     "User-Agent" => "Flatiron Follower",
        #     "Authorization" => "token #{auth_token}"
        #   },
        #   body:{}
        # } 
        connection.put("https://api.twitter.com/1.1/friendships/create.json?screen_name=#{username}&amp;follow=true")
      end     
    end

    def unfollow(cohort_id)
     students = Student.where(cohort_id: cohort_id)
      students.each do |student|
        username = student.twitter_handle
        # options = {
        #   headers:{
        #     "User-Agent" => "Flatiron Follower",
        #     "Authorization" => "token #{auth_token}"
        #   },
        #   body:{}
        # } 
        connection.delete("https://api.twitter.com/1.1/friendships/destroy.json?screen_name=#{username}")
      end     
    end

  end