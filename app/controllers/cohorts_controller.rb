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

  def follow_params
    params.permit(:id, :provider)
  end
  
end
