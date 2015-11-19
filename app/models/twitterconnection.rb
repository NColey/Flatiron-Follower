class TwitterConnection

    attr_reader :connection 

    def initialize(student)
      @student = student
      @client = create_client
    end

    def create_client
      Twitter::REST::Client.new do |config|
        config.consumer_key        = ENV['TWITTER_KEY']
        config.consumer_secret     = ENV['TWITTER_SECRET']
        config.access_token        = @student.token
        config.access_token_secret = @student.secret
      end
    end

    def follow(cohort_id)
      students = Student.where(cohort_id: cohort_id)
      students.each do |student|
        username = student.twitter_handle
        client.follow(username)
      end     
    end

    def unfollow(cohort_id)
      students = Student.where(cohort_id: cohort_id)
      students.each do |student|
        username = student.twitter_handle
         binding.pry
        client.follow(username)
      end     
    end

end
