class Proposal < ApplicationRecord
  belongs_to :hiring_type
  belongs_to :subscription

  validates :company_name, presence: true
  validates :start_date, presence: true
  validates :salary, presence: true
  validates :benefits, presence: true
  validates :role, presence: true
  validates :responsabilities, presence: true

  #TODO start_date must be greater than the current day
end
