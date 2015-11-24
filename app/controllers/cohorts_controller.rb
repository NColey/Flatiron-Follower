class CohortsController < ApplicationController

  def new 
    @cohort = Cohort.new
  end

  def index
    @cohorts = Cohort.all
  end

  def show
    @cohort = Cohort.find(params[:id])
    @students = Student.where(cohort_id: params[:id])
  end

	def create
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
      client = Adapters::GithubConnection.new
      client.follow(token, cohort_id)
    elsif provider =='twitter'
      client = Adapters::TwitterConnection.new
      client.follow(cohort_id)
    end

    render json: {:cohort_id => cohort_id, :cohort_name => cohort_name, :provider => provider}
  end

  def unfollow_cohort
    cohort_id = follow_params[:id]
    provider = follow_params[:provider]
    @student = Student.find_by(id: session[:student_id])

    if provider == 'github'
      token = @student.send(provider)
      client = Adapters::GithubConnection.new
      client.unfollow(token, cohort_id)
    elsif provider == 'twitter'
      @student.token = token
      @student.secret = secret
      client = Adapters::TwitterConnection.new
      client.unfollow(cohort_id, token, secret)
    end
    
    redirect_to current_student
  end

  # def follow_cohort_twitter
  #   cohort_id = follow_params[:id]
  #   provder = follow_params[:provder]
  #   @student = Student.find_by(id: session[:student_id])
  #   client = Adapters::TwitterConnection.new
  #   client.follow(cohort_id)
  #   render json: {:cohort_id => cohort_id}
  # end

  # def unfollow_cohort_twitter
  #   cohort_id = follow_params[:id]
  #   provider = follow_params[:provider]
  #   @student = Student.find_by(id: session[:student_id])
  #   client = Adapters::TwitterConnection.new
  #   client.unfollow(cohort_id)
  #   redirect_to current_student
  # end

  private

	def cohort_params
  	params.require(:cohort).permit(:name, :url)
	end

  def follow_params
    params.permit(:id, :provider)
  end

end
