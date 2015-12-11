# == Schema Information
#
# Table name: students
#
#  id                     :integer          not null, primary key
#  name                   :string
#  cohort_id              :integer
#  email                  :string
#  password_digest        :string
#  created_at             :datetime         not null
#  updated_at             :datetime         not null
#  github_handle          :string
#  linkedin_url           :string
#  twitter_handle         :string
#  encrypted_github       :string
#  provider               :string
#  uid                    :string
#  token                  :string
#  secret                 :string
#  admin                  :boolean
#  activation_digest      :string
#  activated              :boolean
#  activated_at           :datetime
#  password_reset_digest  :string
#  password_reset_sent_at :datetime
#

class Student < ActiveRecord::Base
	belongs_to :cohort
	attr_accessor :activation_token, :reset_token

	#validation
	has_secure_password
	before_update :create_activation_digest, :create_activation_digest
	validates :email, format: {:with => /@flatironschool.com/}
  	attr_encrypted :github, :key => :encryption_key


	def encryption_key
	  ENV['DECRYPT_GITHUB_OAUTH']
	end

    def authenticated?(attribute, token)
        digest = send("#{attribute}_digest")
        return false if digest.nil?
        BCrypt::Password.new(digest).is_password?(token)
    end

    def send_password_reset_email
        StudentEmailConfirmation.password_reset(self).deliver_now
    end

    def create_password_reset_digest
        self.reset_token = Student.new_token
        update_attribute(:password_reset_digest, Student.digest(reset_token))
        update_attribute(:password_reset_sent_at, Time.zone.now)
    end

    def password_reset_expired?
        password_reset_sent_at < 2.hours.ago
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
