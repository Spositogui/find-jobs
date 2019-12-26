require 'rails_helper'

feature 'Headhunter sees all applicants for a job' do
  scenario 'successfully' do
    candidate_formation = CandidateFormation.create!(name: 'Cursando superior')
    candidate = Candidate.create!(email: 'candi@cand.com', password: '123456')
    CandidateProfile.create!(name: 'Alan Turing', nickname: 'Alan',
                            date_of_birth: '02/05/1994',
                            candidate_formation: candidate_formation,
                            description: 'Lorem Ipsum is simply',
                            experience: 'Lorem ipsum dolor sit amet',
                            candidate: candidate)
    candidate2 = Candidate.create!(email: 'candi2@cand.com', password: '123456')
    CandidateProfile.create!(name: 'Keanu Reeves', nickname: 'Neo',
                            date_of_birth: '02/07/1964',
                            candidate_formation: candidate_formation,
                            description: 'Lorem Ipsum is simply',
                            experience: 'Lorem ipsum dolor sit amet',
                            candidate: candidate2)
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
    job.subscriptions.create!(candidate: candidate2, 
                              candidate_description: 'Experiencia com mais de 30 anos')

    login_as(head_hunter, scope: :head_hunter)
    visit root_path
    click_on 'Vagas cadastradas'
    click_on 'Dev Jr'
    click_on 'Ver candidatos'

    expect(page).to have_content('Vaga: Dev Jr')
    expect(page).to have_content('Candidatos:') 
    expect(page).to have_link(candidate.candidate_profile.name)
    expect(page).to have_link(candidate2.candidate_profile.name) 
  end

  scenario 'can see the candidate profile' do
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
                      salary: '1200.00', experience_level: xp,
                      hiring_type: hiring_type, address: 'Av. Ruby, 250',
                      registration_end_date: 5.days.from_now,
                      head_hunter: head_hunter)
    job2 = Job.create!(title: 'Dev Ruby', description: 'Ipsum Jr', home_office: :nao,
                      skills_description: 'Lorem ipsum dolor sit.',
                      salary: '3200.00', experience_level: xp,
                      hiring_type: hiring_type, address: 'Av. Ruby, 250',
                      registration_end_date: 5.days.from_now,
                      head_hunter: head_hunter)
    job.subscriptions.create!(candidate: candidate, 
                              candidate_description: 'Experiencia com mais de 10 anos')
    job2.subscriptions.create!(candidate: candidate, 
                              candidate_description: 'Experiencia com mais de 5 anos')

    login_as(head_hunter, scope: :head_hunter)
    visit subscribers_job_path(job2)
    click_on 'Alan Turing'

    expect(current_path).to eq(candidate_profile_path(candidate))
    expect(page).to have_content('Nome: Alan Turing')
    expect(page).to have_content('Nome social: Alan')
    expect(page).to have_content('Data de nascimento: 02/05/1994')
    expect(page).to have_content('Formação: Cursando superior')
    expect(page).to have_content('Descrição: Lorem Ipsum is simply')
    expect(page).to have_content('Experiência: Lorem ipsum dolor sit amet')  
  end

  scenario 'without candidates' do
    head_hunter = HeadHunter.create!(email: 'head@code.com', password: '123456')
    xp = ExperienceLevel.create!(name: 'Júnior')
    hiring_type = HiringType.create!(name: 'PJ')
    job = Job.create!(title: 'Dev Jr', description: 'Ipsum Jr', home_office: :nao,
                      skills_description: 'Lorem ipsum dolor sit.',
                      salary: '1200.00', experience_level: xp,
                      hiring_type: hiring_type, address: 'Av. Ruby, 250',
                      registration_end_date: 5.days.from_now,
                      head_hunter: head_hunter)

    login_as(head_hunter, scope: :head_hunter)
    visit subscribers_job_path(job)

    expect(page).to have_content('Não há candidatos inscritos para essa vaga no momento.')
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

    visit subscribers_job_path(job)

    expect(page).to have_content('Você não tem autorização para acessar essa página')
  end
end