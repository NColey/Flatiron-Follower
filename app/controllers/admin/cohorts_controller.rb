class Admin::CohortsController < ApplicationController
  before_action :authorized?

  def new 
    @cohort = Cohort.new
  end

  def index
    @cohorts = Cohort.all
  end

  def show
    @cohort = Cohort.find(params[:id])
  end

	def create
    @cohort = Cohort.new(cohort_params)
    @cohort.save 
    redirect_to admin_cohort_path(@cohort)
  end

  def scrape
    @cohort = Cohort.find(params[:id])
    scraper = Scraper.new(@cohort.url, @cohort.id)
    scraper.scrape_student_info
    redirect_to admin_cohort_path(@cohort)
  end

  def edit
    @cohort = Cohort.find(params[:id])
  end

  def update
    @cohort = Cohort.find(params[:id])
    @cohort.update(cohort_params)
    redirect_to admin_cohort_path(@cohort)
  end

  def destroy
    @cohort = Cohort.find(params[:id])
    @cohort.destroy
    redirect_to admin_cohorts_path
  end


private

	def cohort_params
  	params.require(:cohort).permit(:name, :url)
	end

end
