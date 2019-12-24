class Subscription < ApplicationRecord
  belongs_to :candidate
  belongs_to :job
  validates :candidate_description, presence: true, length: {minimum: 10}
end
