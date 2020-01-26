require 'rails_helper'

feature 'Candidate receives proposals for a job' do
  context 'via My proposal in menu' do
    scenario 'successfully' do
      candidate_formation = CandidateFormation.create!(name: 'Cursando superior')
      candidate = Candidate.create!(email: 'candi@cand.com', password: '123456')
      CandidateProfile.create!(name: 'Alan Turing', nickname: 'Alan',
                              date_of_birth: '02/05/1994',
                              candidate_formation: candidate_formation,
                              description: 'Lorem Ipsum is simply',
                              experience: 'Lorem ipsum dolor sit amet',
                              candidate: candidate)
      head_hunter = HeadHunter.create!(email: 'head@code.com', password: '123456')
      xp = ExperienceLevel.create!(name: 'Júnior')
      hiring_type = HiringType.create!(name: 'PJ')
      job = Job.create!(title: 'Dev Jr', description: 'Ipsum Jr', home_office: :nao,
                        skills_description: 'Lorem ipsum dolor sit.',
                        salary: '2500.00', experience_level: xp,
                        hiring_type: hiring_type, address: 'Av. Ruby, 250',
                        registration_end_date: 5.days.from_now,
                        head_hunter: head_hunter)
      subscription = Subscription.create!(candidate: candidate, job: job,
                                          candidate_description: 'Experiencia com mais de 10 anos')
      Proposal.create!(company_name: 'Campus', start_date: 1.day.from_now,
                      salary: '2500.00', benefits: 'some benefits', role: 'Dev Jr',
                      responsabilities: 'some responsabilities', hiring_type: hiring_type,
                      others: 'Lorem ipsum dolor sit amet', subscription: subscription)

      login_as(candidate, scope: :candidate)
      visit root_path
      click_on 'Minhas propostas'

      expect(page).to have_content('Olá Alan Turing, aqui estão suas propostas:')
      expect(page).to have_content('Empresa: Campus')
      expect(page).to have_content('Cargo: Dev Jr')
    end

    scenario 'can see the proposal' do
      candidate_formation = CandidateFormation.create!(name: 'Cursando superior')
      candidate = Candidate.create!(email: 'candi@cand.com', password: '123456')
      CandidateProfile.create!(name: 'Alan Turing', nickname: 'Alan',
                              date_of_birth: '02/05/1994',
                              candidate_formation: candidate_formation,
                              description: 'Lorem Ipsum is simply',
                              experience: 'Lorem ipsum dolor sit amet',
                              candidate: candidate)
      head_hunter = HeadHunter.create!(email: 'head@code.com', password: '123456')
      xp = ExperienceLevel.create!(name: 'Júnior')
      hiring_type = HiringType.create!(name: 'PJ')
      job = Job.create!(title: 'Dev Jr', description: 'Ipsum Jr', home_office: :nao,
                        skills_description: 'Lorem ipsum dolor sit.',
                        salary: '2500.00', experience_level: xp,
                        hiring_type: hiring_type, address: 'Av. Ruby, 250',
                        registration_end_date: 5.days.from_now,
                        head_hunter: head_hunter)
      subscription = Subscription.create!(candidate: candidate, job: job,
                                          candidate_description: 'Experiencia com mais de 10 anos')
      Proposal.create!(company_name: 'Campus', start_date: 1.day.from_now,
                      salary: '2500.00', benefits: 'some benefits', role: 'Dev Jr',
                      responsabilities: 'some responsabilities', hiring_type: hiring_type,
                      others: 'Lorem ipsum dolor sit amet', subscription: subscription)

      login_as(candidate, scope: :candidate)
      visit my_proposals_path
      click_on 'Campus'

      expect(page).to have_content('Empresa: Campus')
      expect(page).to have_content("Data de ínicio: #{1.day.from_now.strftime('%d/%m/%Y')}")
      expect(page).to have_content("Salário: R$ 2.500,00")
      expect(page).to have_content('Benefícios: some benefits')
      expect(page).to have_content('Cargo: Dev Jr')
      expect(page).to have_content('Responsabilidades: some responsabilities')
      expect(page).to have_content('Tipo de contratação: PJ')
      expect(page).to have_content('Outros: Lorem ipsum dolor sit amet') 
    end

    scenario 'dont have any proposal' do
      candidate_formation = CandidateFormation.create!(name: 'Cursando superior')
      candidate = Candidate.create!(email: 'candi@cand.com', password: '123456')
      CandidateProfile.create!(name: 'Alan Turing', nickname: 'Alan',
                              date_of_birth: '02/05/1994',
                              candidate_formation: candidate_formation,
                              description: 'Lorem Ipsum is simply',
                              experience: 'Lorem ipsum dolor sit amet',
                              candidate: candidate)
      
      login_as(candidate, scope: :candidate)
      visit my_proposals_path
      
      expect(page).to have_content('Você não tem nenhuma proposta no momento.')  
    end

    scenario 'must be logged' do
      visit my_proposals_path

      expect(page).to have_content('Para continuar, faça login ou registre-se')
    end
  end

  context 'via My Vacancies' do
    scenario 'successfully' do
      candidate_formation = CandidateFormation.create!(name: 'Cursando superior')
      candidate = Candidate.create!(email: 'candi@cand.com', password: '123456')
      CandidateProfile.create!(name: 'Alan Turing', nickname: 'Alan',
                              date_of_birth: '02/05/1994',
                              candidate_formation: candidate_formation,
                              description: 'Lorem Ipsum is simply',
                              experience: 'Lorem ipsum dolor sit amet',
                              candidate: candidate)
      head_hunter = HeadHunter.create!(email: 'head@code.com', password: '123456')
      xp = ExperienceLevel.create!(name: 'Júnior')
      hiring_type = HiringType.create!(name: 'PJ')
      job = Job.create!(title: 'Dev Jr', description: 'Ipsum Jr', home_office: :nao,
                        skills_description: 'Lorem ipsum dolor sit.',
                        salary: '2500.00', experience_level: xp,
                        hiring_type: hiring_type, address: 'Av. Ruby, 250',
                        registration_end_date: 5.days.from_now,
                        head_hunter: head_hunter)
      subscription = Subscription.create!(candidate: candidate, job: job,
                                          candidate_description: 'Experiencia com mais de 10 anos')
      Proposal.create!(company_name: 'Campus', start_date: 1.day.from_now,
                      salary: '2500.00', benefits: 'some benefits', role: 'Dev Jr',
                      responsabilities: 'some responsabilities', hiring_type: hiring_type,
                      others: 'Lorem ipsum dolor sit amet', subscription: subscription)

      login_as(candidate, scope: :candidate)
      visit root_path
      click_on 'Minhas vagas'
      click_on 'Propostas'

      expect(page).to have_content('Olá Alan Turing, aqui estão suas propostas:')
      expect(page).to have_content('Empresa: Campus')
      expect(page).to have_content('Cargo: Dev Jr')
    end

    scenario 'must be logged' do
     visit my_vacancies_path
     
     expect(page).not_to have_link('Propostas')
     expect(page).to have_content('Você não tem autorização para acessar essa página')
    end
  end
end