class Student < ActiveRecord::Base
	belongs_to :cohort
	attr_accessor :remember_token, :activation_token

	#validation
	# has_secure_password
	# before_update :create_activation_digest
	validates :email, format: {:with => /@flatironschool.com/}#, uniqueness: {case_sensitive: false}, 
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

    def authenticated?(attribute, token)
        digest = send("#{attribute}_digest")
        return false if digest.nil?
        BCrypt::Password.new(digest).is_password?(token)
    end

    private

    def self.new_token
    	SecureRandom.urlsafe_base64
    end

    def self.digest(string)
        cost = ActiveModel::SecurePassword.min_cost ? BCrypt::Engine::MIN_COST : BCrypt::Engine.cost
        BCrypt::Password.create(string, cost: cost)
    end

    def create_activation_digest
    	if !self.activated
	    	self.activation_token = Student.new_token
	    	self.activation_digest = Student.digest(activation_token)
	    end
    end

end
