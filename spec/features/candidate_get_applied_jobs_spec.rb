require 'rails_helper'

feature 'Candidate get all applied jobs' do
  scenario 'successfully' do
    candidate = Candidate.create!(email: 'candi@cand.com', password: '123456')
    candidate_formation = CandidateFormation.create!(name: 'Cursando superior')
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
                      salary: '1200.00', experience_level: xp,
                      hiring_type: hiring_type, address: 'Av. Ruby, 250',
                      registration_end_date: 5.days.from_now,
                      head_hunter: head_hunter)
    job.subscriptions.create!(candidate: candidate, 
                              candidate_description: 'Experiencia com mais de 10 anos')

    login_as(candidate, scope: :candidate)
    visit root_path
    click_on 'Minhas vagas'

    expect(page).to have_content('Aqui estão suas vagas, Alan:')
    expect(page).to have_link('Dev Jr')
    expect(page).to have_content('Av. Ruby, 250')
  end

  scenario 'can view vacancy informations' do
    candidate = Candidate.create!(email: 'candi@cand.com', password: '123456')
    candidate_formation = CandidateFormation.create!(name: 'Cursando superior')
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
                      salary: '1200.00', experience_level: xp,
                      hiring_type: hiring_type, address: 'Av. Ruby, 250',
                      registration_end_date: 5.days.from_now,
                      head_hunter: head_hunter)
    job.subscriptions.create!(candidate: candidate, 
                              candidate_description: 'Experiencia com mais de 10 anos')

    login_as(candidate, scope: :candidate)
    visit my_vacancies_path
    click_on 'Dev Jr'
    
    expect(page).to have_content('Dev Jr')
		expect(page).to have_content("Descrição da vaga: Ipsum Jr")
		expect(page).to have_content("Habilidades desejadas: Lorem ipsum dolor sit.")
		expect(page).to have_content("Salário: R$ 1.200,00")
		expect(page).to have_content("Nível de experiência: Júnior")
		expect(page).to have_content("Tipo de contratação: PJ")
		expect(page).to have_content("Endereço: Av. Ruby, 250")
		expect(page).to have_content("Remoto: Nao")
    expect(page).to have_content("Data de expiração da vaga: #{5.days.from_now.strftime('%d/%m/%Y')}")
    expect(page).not_to have_link('Candidatar-me') 
  end

  scenario 'must be logged' do
    head_hunter = HeadHunter.create!(email: 'head@code.com', password: '123456')
    xp = ExperienceLevel.create!(name: 'Júnior')
    hiring_type = HiringType.create!(name: 'PJ')
    job = Job.create!(title: 'Dev Jr', description: 'Ipsum Jr', home_office: :nao,
                      skills_description: 'Lorem ipsum dolor sit.',
                      salary: '1200.00', experience_level: xp,
                      hiring_type: hiring_type, address: 'Av. Ruby, 250',
                      registration_end_date: 5.days.from_now,
                      head_hunter: head_hunter)

    visit my_vacancies_path

    expect(page).to have_content('Você não tem autorização para acessar essa página')
  end

  scenario 'candidate profile must be filled' do
    candidate = Candidate.create!(email: 'candi@cand.com', password: '123456')
    head_hunter = HeadHunter.create!(email: 'head@code.com', password: '123456')
    xp = ExperienceLevel.create!(name: 'Júnior')
    hiring_type = HiringType.create!(name: 'PJ')
    job = Job.create!(title: 'Dev Jr', description: 'Ipsum Jr', home_office: :nao,
                      skills_description: 'Lorem ipsum dolor sit.',
                      salary: '1200.00', experience_level: xp,
                      hiring_type: hiring_type, address: 'Av. Ruby, 250',
                      registration_end_date: 5.days.from_now,
                      head_hunter: head_hunter)
    job.subscriptions.create!(candidate: candidate, 
                              candidate_description: 'Experiencia com mais de 10 anos')

    login_as(candidate, scope: :candidate)
    visit my_vacancies_path

    expect(page).to have_content('Você não tem autorização para acessar essa página')
  end

  scenario 'candidate profile must be filled to see button' do
    candidate = Candidate.create!(email: 'candi@cand.com', password: '123456')
    head_hunter = HeadHunter.create!(email: 'head@code.com', password: '123456')
    xp = ExperienceLevel.create!(name: 'Júnior')
    hiring_type = HiringType.create!(name: 'PJ')
    job = Job.create!(title: 'Dev Jr', description: 'Ipsum Jr', home_office: :nao,
                      skills_description: 'Lorem ipsum dolor sit.',
                      salary: '1200.00', experience_level: xp,
                      hiring_type: hiring_type, address: 'Av. Ruby, 250',
                      registration_end_date: 5.days.from_now,
                      head_hunter: head_hunter)
    job.subscriptions.create!(candidate: candidate, 
                              candidate_description: 'Experiencia com mais de 10 anos')

    login_as(candidate, scope: :candidate)
    visit root_path

    expect(page).not_to have_link('Minhas vagas')
  end
end             