class Subscription < ApplicationRecord
  belongs_to :candidate
  belongs_to :job
  has_one :proposal

  enum markup: [:unhighlighted, :highlighted]

  validates :candidate_description, presence: true, length: {minimum: 10}
end
