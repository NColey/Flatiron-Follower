class TwitterConnection

  attr_reader :client
  attr_accessor :flash_notice

  def initialize(user)
    @user = user
    @client = create_client
  end

  def create_client
    Twitter::REST::Client.new do |config|
      config.consumer_key = ENV['TWITTER_KEY']
      config.consumer_secret = ENV['TWITTER_SECRET']
      config.access_token = @user.token
      config.access_token_secret = @user.secret
    end
  end

  def follow_one(username)
    @client.follow(username)
  end

  #Twitter::Error::Forbidden: You've already requested to follow dodgerredhead.
  #Twitter::Error::NotFound: No user matches for specified terms. #yifan
  #Twitter::Error::TooManyRequests: Rate limit exceeded

  def follow(cohort_id)
      students = Student.where(cohort_id: cohort_id)
      students.each do |student|
        if student.twitter_handle != "" && student.twitter_handle != "nessiejadler"
            username = student.twitter_handle
            @client.follow(username)
        end
      end     
  end

  def unfollow(cohort_id)
      students = Student.where(cohort_id: cohort_id) 
      students.each do |student|
        if student.twitter_handle != "" && student.twitter_handle != "nessiejadler"
          username = student.twitter_handle
          @client.unfollow(username)
        end
      end     
  end

end