class CandidateProfilesController < ApplicationController
  before_action :authenticate_candidate!, unless: :head_hunter_signed_in?
  load_and_authorize_resource
  before_action :set_candidate_profile, only: [:show, :edit, :update]

  def show
    @candidate = @candidate_profile.candidate
  end
  
  def new
    @candidate_profile = CandidateProfile.new
    get_candidate_formations
  end

  def edit
    get_candidate_formations
  end

  def create 
    @candidate_profile = CandidateProfile.new(candidate_profile_params)
    @candidate_profile.candidate = current_candidate
    if @candidate_profile.save
      flash[:notice] = I18n.t('candidate_profile.message.profile_success')
      redirect_to @candidate_profile
    else
      get_candidate_formations
      render :new
    end
  end

  def update
    if @candidate_profile.update(candidate_profile_params)
      flash[:notice] = I18n.t('candidate_profile.message.update_profile_success')
      redirect_to @candidate_profile
    else
      get_candidate_formations
      render :edit
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

  def set_candidate_profile
    @candidate_profile = CandidateProfile.find(params[:id])
  end

  def get_candidate_formations
    @candidate_formations = CandidateFormation.all
  end
end