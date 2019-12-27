class Candidate < ApplicationRecord
  has_one :candidate_profile
  has_many :subscriptions
  has_many :jobs, through: :subscriptions
  has_many :comments
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
end
