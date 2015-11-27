class Student < ActiveRecord::Base
	belongs_to :cohort

	#validation
	has_secure_password
	validates_format_of :email, :with => /@flatironschool.com/
  	attr_encrypted :github, :key => :encryption_key


	def encryption_key
	  ENV['DECRYPT_GITHUB_OAUTH']
	end
  
  def twitter_client
    @client ||= Adapters::TwitterConnection.new
  end

  def github_client
    @client ||= Adapters::GithubConnection.new
  end

end
