# == Schema Information
#
# Table name: cohorts
#
#  id         :integer          not null, primary key
#  name       :string
#  url        :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class Cohort < ActiveRecord::Base
	has_many :students
end
