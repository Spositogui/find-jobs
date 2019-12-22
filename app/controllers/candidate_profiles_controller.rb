class CandidateProfilesController < ApplicationController
  before_action :authenticate_candidate!

  def show
    @candidate_profile = CandidateProfile.find(params[:id])
  end
  
  def new
    @candidate_profile = CandidateProfile.new
    @candidate_formations = CandidateFormation.all
  end

  def create 
    @candidate_profile = CandidateProfile.new(candidate_profile_params)
    @candidate_profile.candidate = current_candidate
    if @candidate_profile.save
      redirect_to @candidate_profile
      flash[:notice] = I18n.t('candidate_profile.message.profile_success')
    else
      @candidate_formations = CandidateFormation.all
      render :new
    end
  end

  private
  def candidate_profile_params
    params.require(:candidate_profile).permit(:name, :nickname,
                                              :date_of_birth,
                                              :candidate_formation_id,
                                              :description,
                                              :experience,
                                              :avatar)
  end
end