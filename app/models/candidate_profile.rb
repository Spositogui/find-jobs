class CandidateProfile < ApplicationRecord
  belongs_to :candidate
  belongs_to :candidate_formation
  has_one_attached :avatar

  validates :name, presence: true, length: {minimum: 2, maximum: 40}
  validates :date_of_birth, presence: true
  validates :description, presence: true

  #TODO validates age grater than 18years
end
