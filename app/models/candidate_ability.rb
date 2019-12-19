class CandidateAbility
  include CanCan::Ability

  def initialize(candidate)
    if candidate.present?
      cannot :manage, Job
    end
  end
end