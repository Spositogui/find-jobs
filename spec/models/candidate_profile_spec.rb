require 'rails_helper'

RSpec.describe CandidateProfile, type: :model do
  describe '.must_be_over_seventeen_years_old' do
    it 'success' do
      candidate = Candidate.new(email: 'joe@hotmail.com', password: '123456')
      candidate_formation = CandidateFormation.new(name: 'Cursando superior')
      candidate_profile = CandidateProfile.new(name: 'Alan Turing', nickname: 'Alan',
                                                   date_of_birth: '02/05/1994',
                                                   candidate_formation: candidate_formation,
                                                   description: 'Lorem Ipsum is simply',
                                                   experience: 'Lorem ipsum dolor sit amet',
                                                   candidate: candidate)

      candidate_profile.valid?

      expect(candidate_profile.errors).to be_empty
    end

    it 'eighteen this year but in the coming month' do
      day = Date.current.day
      month = Date.current.months_since(1).month
      year = Date.current.month != 12 ? Date.current.years_ago(18).year : Date.current.years_ago(17).year
      candidate_p = CandidateProfile.new(date_of_birth: "#{day}/#{month}/#{year}")
      
      candidate_p.valid?

      expect(candidate_p.errors.full_messages).to include('Data de nascimento erro. Você deve ter 18 anos ou mais.')
    end

    it 'eighteen this year but in the coming days' do
      day = Date.current.days_since(4).day
      month = Date.current.month
      year = Date.current.month != 12 ? Date.current.years_ago(18).year : Date.current.years_ago(17).year
      candidate_p = CandidateProfile.new(date_of_birth: "#{day}/#{month}/#{year}")
      
      puts candidate_p.date_of_birth
      candidate_p.valid?

      expect(candidate_p.errors.full_messages).to include('Data de nascimento erro. Você deve ter 18 anos ou mais.')
    end

    it 'age under eighteen' do
      candidate_profile = CandidateProfile.new(date_of_birth: '02/05/2002')

      candidate_profile.valid?

      expect(candidate_profile.errors.full_messages).to include('Data de nascimento erro. Você deve ter 18 anos ou mais.')
    end

    it 'date_of_birth must exist' do
      candidate_profile = CandidateProfile.new

      candidate_profile.valid?

      expect(candidate_profile.errors.full_messages).to include('Data de nascimento não pode ficar em branco')
    end

    it 'date_of_birth cant be blank' do
      candidate_profile = CandidateProfile.new(date_of_birth: '')

      candidate_profile.valid?

      expect(candidate_profile.errors.full_messages).to include('Data de nascimento não pode ficar em branco')
    end
  end
end
