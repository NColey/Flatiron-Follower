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

  def follow(cohort_id)
      students = Student.where(cohort_id: cohort_id)
      students.each do |student|
        if student.twitter_handle != "" && student.twitter_handle != "nessiejadler"
            username = student.twitter_handle
            begin
              @client.follow(username)
            rescue 
            end
        end
      end     
  end

  def unfollow(cohort_id)
      students = Student.where(cohort_id: cohort_id) 
      students.each do |student|
        if student.twitter_handle != "" && student.twitter_handle != "nessiejadler"
          username = student.twitter_handle
          begin
            @client.unfollow(username)
          rescue
          end
        end
      end     
  end

end