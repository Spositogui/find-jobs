class CandidateAbility
  include CanCan::Ability

  def initialize(candidate)
    if candidate.present?
      cannot :manage, Job
      can :read, Job unless candidate.candidate_profile.nil?
    end
  end
end