class AddCandidateRefToCandidateProfile < ActiveRecord::Migration[5.2]
  def change
    add_reference :candidate_profiles, :candidate, foreign_key: true
  end
end
