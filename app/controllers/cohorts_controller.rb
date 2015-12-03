class CohortsController < ApplicationController


  def follow_cohort
    
    cohort_id = follow_params[:id]
    @cohort = Cohort.find(cohort_id)
    cohort_name = @cohort.name

    provider = follow_params[:provider]
    @student = Student.find_by(id: session[:student_id])

    if provider == 'github'
      token = @student.send(provider)
      @student.github_client.follow(token, cohort_id)
    elsif provider == 'twitter'
      twitter = TwitterConnection.new(@student)
      twitter.follow(cohort_id)
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
      twitter.unfollow(cohort_id)
    end
    render json: {:cohort_id => cohort_id, :cohort_name => cohort_name, :provider => provider}
  end

  #Twitter::Error::Forbidden: You've already requested to follow dodgerredhead.
  #Twitter::Error::NotFound: No user matches for specified terms. #yifan #jessie
  #Twitter::Error::TooManyRequests: Rate limit exceeded
  #Twitter::Error::Forbidden: You've already requested to follow hwinn4.
  #Twitter::Error::Forbidden: You've already requested to follow MicheleCavs.
  #Twitter::Error::Forbidden: You can't follow yourself.

  private 

  def follow_params
    params.permit(:id, :provider)
  end

end
