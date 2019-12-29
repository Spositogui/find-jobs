class Job < ApplicationRecord
  belongs_to :experience_level
  belongs_to :hiring_type
  belongs_to :head_hunter
  has_many :subscriptions
  has_many :candidates, through: :subscriptions

  validates :title, presence: true
  validates :description, presence: true
  validates :skills_description, presence: true
  validates :salary, presence: true
  validates :experience_level_id, presence: true
  validates :hiring_type_id, presence: true
  validates :address, presence: true
  validates :registration_end_date, presence: true
  validate :registration_end_date_must_be_grater_than_current_day

  enum home_office: [:nao, :sim]
  enum status: [:active, :inactive]

  def registration_end_date_must_be_grater_than_current_day
    return unless registration_end_date.present?

    if registration_end_date <= Date.current
      errors.add(:registration_end_date, 'deve ser maior que a data atual.')
    end
  end
end
