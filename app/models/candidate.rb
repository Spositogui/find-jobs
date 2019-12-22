class Candidate < ApplicationRecord
  has_one :candidate_profile
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
end
