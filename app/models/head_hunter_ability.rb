class HeadHunterAbility
  include CanCan::Ability
  
  def initialize(head_hunter)
    if head_hunter.present?
      can :manage, Job
      can :read, CandidateProfile
    end
  end
end