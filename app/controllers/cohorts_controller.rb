class CohortsController < ApplicationController

	def create
    	@cohort = Cohort.new(cohort_params)
  	end

  	private

  	def cohort_params
    	params.require(:cohort).permit(:name, :url)
  	end
end
