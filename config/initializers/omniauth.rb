Rails.application.config.middleware.use OmniAuth::Builder do
  provider :github, ENV['GITHUB_KEY'], ENV['GITHUB_SECRET']
  provider :twitter, ENV['TWITTER_KEY'], ENV['TWITTER_SECRET'],
  {
  	:authorize_params => {
  		screen_name: 'true',
  		use_authorize: 'true'
  	}
  }
end