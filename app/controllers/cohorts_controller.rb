class CohortsController < ApplicationController

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
    redirect_to @cohort
  end

  def scrape
    @cohort = Cohort.find(params[:id])
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
    redirect_to @cohort
  end

  def destroy
    @cohort = Cohort.find(params[:id])
    @cohort.destroy
    redirect_to cohorts_path
  end


  def follow_cohort
    cohort_id = follow_params[:id]
    @cohort = Cohort.find(cohort_id)
    cohort_name = @cohort.name

    provider = follow_params[:provider]
    @student = Student.find_by(id: session[:student_id])

    if provider == 'github'
      token = @student.send(provider)
      @student.github_client.follow(token, cohort_id)
    elsif provider =='twitter'
      twitter = TwitterConnection.new(@student)
      begin
        twitter.follow(cohort_id)
      rescue
        flash.now[:alert] = "Some of your classmates have suspended or protected accounts. You have followed everyone else."
      end
    end
    render json: {:cohort_id => cohort_id, :cohort_name => cohort_name, :provider => provider}
  end

  def unfollow_cohort
    cohort_id = follow_params[:id]
    @cohort = Cohort.find(cohort_id)
    cohort_name = @cohort.name

    provider = follow_params[:provider]
    @student = Student.find_by(id: session[:student_id])

    if provider == 'github'
      token = @student.send(provider)
      @student.github_client.unfollow(token, cohort_id)
    elsif provider == 'twitter'
      twitter = TwitterConnection.new(@student)
      begin
        twitter.unfollow(cohort_id)
      rescue
        flash.now[:alert] = "Some of your classmates have suspended or protected accounts. You have unfollowed everyone else."
      end
    end
    render json: {:cohort_id => cohort_id, :cohort_name => cohort_name, :provider => provider}
  end

private

	def cohort_params
  	params.require(:cohort).permit(:name, :url)
	end

  def follow_params
    params.permit(:id, :provider)
  end

end
