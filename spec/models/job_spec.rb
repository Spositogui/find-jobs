require 'rails_helper'

RSpec.describe Job, type: :model do
  describe '.registration_end_date_must_be_grater_than_current_day' do
    it 'success' do
      head_hunter = HeadHunter.create(email: 'head@code.com', password: '123456')
      xp = ExperienceLevel.create(name: 'Júnior')
      hiring_type = HiringType.create(name: 'PJ')
      job = Job.create(title: 'Dev Jr', description: 'Ipsum Jr', home_office: :nao,
                    skills_description: 'Lorem ipsum dolor sit.',
                    salary: '1200.00', experience_level: xp,
                    hiring_type: hiring_type, address: 'Av. Ruby, 250',
                    registration_end_date: 5.days.from_now,
                    head_hunter: head_hunter)

      job.valid?

      expect(job.errors).to be_empty
    end

    it 'the next day' do
      head_hunter = HeadHunter.create(email: 'head@code.com', password: '123456')
      xp = ExperienceLevel.create(name: 'Júnior')
      hiring_type = HiringType.create(name: 'PJ')
      job = Job.create(title: 'Dev Jr', description: 'Ipsum Jr', home_office: :nao,
                    skills_description: 'Lorem ipsum dolor sit.',
                    salary: '1200.00', experience_level: xp,
                    hiring_type: hiring_type, address: 'Av. Ruby, 250',
                    registration_end_date: 1.days.from_now,
                    head_hunter: head_hunter)
    end

    it 'same as this current day' do
      job = Job.new(registration_end_date: Date.current)

      job.valid?

      expect(job.errors.full_messages).to include('Data de expiração da vaga deve ser maior que a data atual.')  
    end

    it 'last day' do
      job = Job.new(registration_end_date: Date.current.days_ago(1))

      job.valid?

      expect(job.errors.full_messages).to include('Data de expiração da vaga deve ser maior que a data atual.')
    end

    it 'two days ago' do
      job = Job.new(registration_end_date: Date.current.days_ago(1))

      job.valid?

      expect(job.errors.full_messages).to include('Data de expiração da vaga deve ser maior que a data atual.')
    end

    it 'many days ago' do
      job = Job.new(registration_end_date: Date.current.days_ago(50))

      job.valid?

      expect(job.errors.full_messages).to include('Data de expiração da vaga deve ser maior que a data atual.')
    end

    it 'must be exist' do
      job = Job.new(registration_end_date: nil)

      job.valid?

      expect(job.errors.full_messages).to include('Data de expiração da vaga não pode ficar em branco')
    end

    it 'cant be blank' do
      job = Job.new(registration_end_date: '')

      job.valid?

      expect(job.errors.full_messages).to include('Data de expiração da vaga não pode ficar em branco')
    end
  end
end
