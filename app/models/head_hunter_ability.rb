class HeadHunterAbility
  include CanCan::Ability
  
  def initialize(head_hunter)
    if head_hunter.present?
      can :manage, Job
      can :read, CandidateProfile, @candidate_profile
      can [:new, :create], Comment
      can [:new, :create], Proposal
      can :highlight_candidate, Subscription
    end
  end
end