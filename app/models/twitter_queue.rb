class TwitterQueue < ActiveRecord::Base

    REQUEST_QUEUE = {}

    def try_social_media_request
        current_request_cycle = self.class.where("created_at >= ?", 15.minutes.ago)
        if current_request_cycle.count > 15
            add_twitter_request_data_to_queue(self.id, self.social_media_method, self.cohort_id)
            delay_and_retry_social_media_request(self, self.cohort_id)
        elsif REQUEST_QUEUE.count > 0
            student = Student.find(REQUEST_QUEUE.keys[0])
            social_media_method = REQUEST_QUEUE.values[0][0]
            cohort_id = REQUEST_QUEUE.values[1][1]
            REQUEST_QUEUE.delete(student.id)

            twitter = SocialMediaManager.twitter_client(student)
            twitter.send(social_media_method, cohort_id)
        else
            student = Student.find(self.id)
            twitter = SocialMediaManager.twitter_client(student)
            twitter.send(self.social_media_method, self.cohort_id)
        end
    end

    def add_twitter_request_data_to_queue(student_id, social_media_method, cohort_id)
        REQUEST_QUEUE[student_id] = [social_media_method, cohort_id]
    end

    def delay_and_retry_social_media_request(student, cohort_id)
        sleep 15.minutes
        twitter = SocialMediaManager.twitter_client(student)
        twitter.send(social_media_method, cohort_id)
    end
end