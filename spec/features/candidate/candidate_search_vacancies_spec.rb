require 'rails_helper'

feature 'Candidate seach for vacancies' do
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
    Job.create!(title: 'Dev Jr', description: 'Ipsum Jr', home_office: :nao,
                skills_description: 'Lorem ipsum dolor sit.',
                salary: '1200.00', experience_level: xp,
                hiring_type: hiring_type, address: 'Av. Ruby, 250',
                registration_end_date: 5.days.from_now,
                head_hunter: head_hunter)
    Job.create!(title: 'Dev Sênior', description: 'Impsum lorem', home_office: :nao,
                skills_description: 'Lorem ipsum dolor sit.',
                salary: '5200.00', experience_level: xp,
                hiring_type: hiring_type, address: 'Av. Rails, 250',
                registration_end_date: 5.days.from_now,
                head_hunter: head_hunter)
    Job.create!(title: 'Programmer', description: 'Lorem ipsum, Dev Jr', home_office: :nao,
                skills_description: 'Lorem ipsum dolor sit.',
                salary: '1200.00', experience_level: xp,
                hiring_type: hiring_type, address: 'Av. Amador, 3200',
                registration_end_date: 5.days.from_now,
                head_hunter: head_hunter)

    login_as(candidate, scope: :candidate)
    visit root_path
    fill_in 'Localizar vagas', with: 'Dev Jr'
    click_on 'Buscar'
    
    expect(page).to have_content('Resultados da busca:')
    expect(page).to have_content('Dev Jr')
    expect(page).to have_content('Av. Ruby, 250')
    expect(page).to have_content('Programmer')
    expect(page).to have_content('Av. Amador, 3200')
    expect(page).not_to have_content('Dev Sênior')
    expect(page).not_to have_content('Av. Rails, 250')
  end

  scenario 'inactive vacancies should not appear' do
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
    Job.create!(title: 'Dev Jr', description: 'Ipsum Jr', home_office: :nao,
                skills_description: 'Lorem ipsum dolor sit.',
                salary: '1200.00', experience_level: xp,
                hiring_type: hiring_type, address: 'Av. Ruby, 250',
                registration_end_date: 5.days.from_now,
                head_hunter: head_hunter, status: :inactive)
    Job.create!(title: 'Dev Sênior', description: 'Impsum lorem', home_office: :nao,
                skills_description: 'Lorem ipsum dolor sit.',
                salary: '5200.00', experience_level: xp,
                hiring_type: hiring_type, address: 'Av. Rails, 250',
                registration_end_date: 5.days.from_now,
                head_hunter: head_hunter, status: :inactive)
    Job.create!(title: 'Dev Pleno', description: 'Lorem ipsum, Dev Jr', home_office: :nao,
                skills_description: 'Lorem ipsum dolor sit.',
                salary: '12000.00', experience_level: xp,
                hiring_type: hiring_type, address: 'Av. Amador, 3200',
                registration_end_date: 5.days.from_now,
                head_hunter: head_hunter)

    login_as(candidate, scope: :candidate)
    visit root_path
    fill_in 'Localizar vagas', with: 'Dev'
    click_on 'Buscar'
     
    expect(page).to have_content('Dev Pleno')  
    expect(page).not_to have_content('Dev Jr')
    expect(page).not_to have_content('Dev Sênior')
  end

  scenario 'must be logged' do
    visit root_path

    expect(page).not_to have_content('Localizar vagas')
  end

  scenario 'profile must be filled to make searches' do
    candidate = Candidate.create!(email: 'candi@cand.com', password: '123456')

    login_as(candidate, scope: :candidate)
    visit search_jobs_path

    expect(page).not_to have_content('Localizar vagas')
    expect(page).to have_content('Você não tem autorização para acessar essa página')
  end
end