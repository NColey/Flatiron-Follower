class Student < ActiveRecord::Base
	belongs_to :cohort

	#validation
	has_secure_password
	validates_format_of :email, :with => /@flatironschool.com/
end
