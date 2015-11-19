module Adapters
  class TwitterConnection
    include HTTParty

    attr_reader :connection 

    def initialize
      @connection = self.class
    end

    # def oauth_nonce
    #   oauth_nonce = [*('a'..'z'),*('0'..'9')].shuffle[0,32].join
    # end

    # def signature(request_method, base_url, oauth_nonce, oauth_signature_method, timestamp, oauth_token, oauth_version)
    # end

    def follow(cohort_id)
      students = Student.where(cohort_id: cohort_id)
      students.each do |student|
        username = student.twitter_handle
        @connection.put("https://api.twitter.com/1.1/friendships/create.json?screen_name=#{username}&amp;follow=true")
      end     
    end

    def unfollow(cohort_id)
      binding.pry
     students = Student.where(cohort_id: cohort_id)
     options = {
          headers:{
            "User-Agent" => "Flatiron Follower",
            "Authorization" => "token #{auth_token}"
          },
          body:{}
        } 
      students.each do |student|
        username = student.twitter_handle
        @connection.delete("https://api.twitter.com/1.1/friendships/destroy.json?screen_name=#{username}")
      end     
    end

  end

end