class SocialMediaManagersController < ApplicationController


  def follow_cohort
    select_social_media_method("follow")
  end

  def unfollow_cohort
    select_social_media_method("unfollow")
  end

  def select_social_media_method(social_media_method)
    cohort_id = follow_params[:id]
    provider = follow_params[:provider]
    @student = Student.find_by(id: session[:student_id])

    SocialMediaManager.follow_or_unfollow_cohort(provider, cohort_id, @student, social_media_method)
    
    render_confirmation_message(provider, cohort_id)
  end

  private 

  def follow_params
    params.permit(:id, :provider)
  end

  def render_confirmation_message(provider, cohort_id)
    @cohort = Cohort.find(cohort_id)
    cohort_name = @cohort.name
    render json: {:cohort_id => cohort_id, :cohort_name => cohort_name, :provider => provider}
  end

end
