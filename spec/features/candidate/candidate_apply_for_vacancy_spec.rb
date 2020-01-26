require 'rails_helper'

feature 'Candidate apply for vacancy' do
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

    login_as(candidate, scope: :candidate)
    visit root_path
    click_on 'Dev Jr'
    click_on 'Candidatar-me'
    fill_in 'Descrição', with: 'Tenho 5 anos de experiência nas tecnologias solicitadas.'
    click_on 'Confirmar'

    expect(current_path).to eq(job_path(job))
    expect(page).to have_content('Parabéns, você acaba de se inscrever para essa vaga.')
    expect(page).not_to have_link('Candidatar-me')
  end

  scenario 'description must be filled' do
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

    login_as(candidate, scope: :candidate)
    visit root_path
    click_on 'Dev Jr'
    click_on 'Candidatar-me'
    click_on 'Confirmar'

    expect(current_path).to eq(cofirmed_subscription_job_path(job))
    expect(page).to have_content('Subscriptions não é válido')
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

    visit subscription_job_path(job)

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

    login_as(candidate, scope: :candidate)
    visit subscription_job_path(job)

    expect(page).to have_content('Você não tem autorização para acessar essa página')
    expect(page).not_to have_link('Candidatar-me')
  end
end
