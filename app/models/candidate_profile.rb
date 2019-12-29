class CandidateProfile < ApplicationRecord
  belongs_to :candidate
  belongs_to :candidate_formation
  has_one_attached :avatar

  validates :name, presence: true, length: {minimum: 2, maximum: 40}
  validates :nickname, presence: true
  validates :date_of_birth, presence: true
  validates :description, presence: true

  validate :must_be_over_seventeen_years_old

  def must_be_over_seventeen_years_old
    return unless date_of_birth.present?

    if Date.current.year - date_of_birth.year < 18
      puts '<18'
      errors.add(:date_of_birth, 'erro. Você deve ter 18 anos ou mais.')
    elsif Date.current.year - date_of_birth.year == 18
      puts 'vai fazer 18 esse ano'
      if Date.current.month < date_of_birth.month
        puts 'proximos meses'
        errors.add(:date_of_birth, 'erro. Você deve ter 18 anos ou mais.')
      elsif Date.current.month == date_of_birth.month
        puts 'esse mes'
        if Date.current.day <  date_of_birth.day
          puts 'próximos dias'
          errors.add(:date_of_birth, 'erro. Você deve ter 18 anos ou mais.')
        end
      end
    end
  end
end
