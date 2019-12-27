class CandidateAbility
  include CanCan::Ability

  def initialize(candidate)
    candidate ||= Candidate.new
    if candidate.email.present?
      unless candidate.candidate_profile.nil?
        can :search, Job
        can :show, Job, @job
        can :subscription, Job, @subscription
        can :cofirmed_subscription, Job
        can :read, Subscription
        can :manage, CandidateProfile
        can :read, Comment
      end

      if candidate.candidate_profile.nil?
        can :create, CandidateProfile
      end
    else
      cannot :manage, Job
    end
  end
end