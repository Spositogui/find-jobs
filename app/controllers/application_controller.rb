class ApplicationController < ActionController::Base

  rescue_from CanCan::AccessDenied do |exception|
    respond_to do |format|
      format.html { redirect_to root_path, notice: exception.message }
    end
  end

  def current_ability
    if head_hunter_signed_in?
      @current_ability ||= HeadHunterAbility.new(current_head_hunter)
    else candidate_signed_in?
      @current_ability ||= CandidateAbility.new(current_candidate)
    end
  end

  def after_sign_in_path_for(resource)

    if head_hunter_signed_in?
      stored_location_for(resource) || root_path
    elsif current_candidate.candidate_profile.nil?
      stored_location_for(resource) || new_candidate_profile_path
    elsif candidate_signed_in?
      stored_location_for(resource) || root_path
    end
    
  end

end
