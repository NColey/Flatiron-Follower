class Student < ActiveRecord::Base
	belongs_to :cohort

  attr_encrypted :github, :key => :encryption_key

  def encryption_key
    ENV['DECRYPT_GITHUB_OAUTH']
  end
  
end
