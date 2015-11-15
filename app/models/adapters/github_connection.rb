module Adapters
  class GithubConnection
    include HTTParty

    attr_reader :connection 

    def initialize
      @connection = self.class
    end

    def follow(token, array)
      array.each do |username|
        connection.put("https://api.github.com/user/following/#{username}?access_token=#{token}", :body =>{})
      end
      #retrieve the access token from database. 
      #iterate over list of github usernames

    end
  end

end