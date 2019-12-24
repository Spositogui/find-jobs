class Candidate < ApplicationRecord
  has_one :candidate_profile
  has_many :subscriptions
  has_many :jobs, through: :subscriptions
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
end
