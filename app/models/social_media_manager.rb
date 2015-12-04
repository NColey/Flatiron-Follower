class SocialMediaManager

	def self.follow_or_unfollow_cohort(provider, cohort_id, student, social_media_method)
	    if provider == 'github'
	        token = student.send(provider)
	        self.github_client.send(social_media_method, *[token, cohort_id])
	    elsif provider == 'twitter'
	        twitter = self.twitter_client(student)
	        twitter.send(social_media_method, cohort_id)
	    end
  	end

  	def self.twitter_client(student)
      @client ||= TwitterConnection.new(student)
    end

    def self.github_client
      @client ||= Adapters::GithubConnection.new
    end

end
