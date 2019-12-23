class CandidateAbility
  include CanCan::Ability

  def initialize(candidate)
    candidate ||= Candidate.new
    if candidate.email.present?
      unless candidate.candidate_profile.nil?
        can :search, Job, @job 
        can :show, Job, @job
      end
    else
      cannot :manage, Job
    end
  end
end