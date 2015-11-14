class CohortsController < ApplicationController

  def new 
    @cohort = Cohort.new
  end

  def index
    @cohorts = Cohort.all
  end

  def show
    @cohort = Cohort.find(params[:id])
    binding.pry
    @students = Student.where(cohort_id: params[:id])
  end

	def create
    binding.pry
    @cohort = Cohort.new(cohort_params)
    @cohort.save 
    scraper = Scraper.new(@cohort.url, @cohort.id)
    scraper.scrape_student_info
    redirect_to @cohort
  end

  def edit
    @cohort = Cohort.find(params[:id])
  end

  def update
    @cohort = Cohort.find(params[:id])
    @cohort.update(cohort_params)
  end

  def destroy
    @cohort = Cohort.find(params[:id])
    @cohort.destroy
  end

  private

	def cohort_params
  	params.require(:cohort).permit(:name, :url)
	end

end
