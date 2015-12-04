class SocialMediaManager

	def follow_or_unfollow_cohort(provider, cohort_id, student)
	    if provider == 'github'
	        token = @student.send(provider)
	        @student.github_client.send(social_media_method, *[token, cohort_id])
	    elsif provider == 'twitter'
	        twitter = TwitterConnection.new(student)
	        twitter.send(social_media_method, cohort_id)
	    end
  	end
end
