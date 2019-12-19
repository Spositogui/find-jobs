class ApplicationController < ActionController::Base

  rescue_from CanCan::AccessDenied do |exception|
    respond_to do |format|
      format.html { redirect_to root_path, notice: exception.message }
    end
  end

  def current_ability
    if head_hunter_signed_in?
      @current_ability ||= HeadHunterAbility.new(current_head_hunter)
    elsif candidate_signed_in?
      @current_ability ||= CandidateAbility.new(current_candidate)
    end
  end
end
