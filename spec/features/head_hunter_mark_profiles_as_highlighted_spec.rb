require 'rails_helper'

feature 'HeadHunter mark profiles as highlighted' do
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
                      salary: '1200.00', experience_level: xp,
                      hiring_type: hiring_type, address: 'Av. Ruby, 250',
                      registration_end_date: 5.days.from_now,
                      head_hunter: head_hunter)
    job.subscriptions.create!(candidate: candidate, 
                              candidate_description: 'Experiencia com mais de 10 anos')

    login_as(head_hunter, scope: :head_hunter)
    visit root_path
    click_on 'Vagas cadastradas'
    click_on 'Dev Jr'
    click_on 'Ver candidatos'
    find('.markup-candidate').click
    
    expect(page).to have_css("i.fas")  
  end

  scenario 'more than one subscriber' do
    candidate_formation = CandidateFormation.create!(name: 'Cursando superior')
    candidate = Candidate.create!(email: 'candi@cand.com', password: '123456')
    CandidateProfile.create!(name: 'Alan Turing', nickname: 'Alan',
                            date_of_birth: '02/05/1994',
                            candidate_formation: candidate_formation,
                            description: 'Lorem Ipsum is simply',
                            experience: 'Lorem ipsum dolor sit amet',
                            candidate: candidate)
    candidate2 = Candidate.create!(email: 'candidate2@gmail.com', password: '123456')
    CandidateProfile.create!(name: 'Keanu', nickname: 'Neo',
                              date_of_birth: '02/05/2000',
                              candidate_formation: candidate_formation,
                              description: 'Lorem Ipsum is simply',
                              experience: 'Lorem ipsum dolor sit amet',
                              candidate: candidate2)
    candidate3 = Candidate.create!(email: 'candidate3@gmail.com', password: '123456')
    CandidateProfile.create!(name: 'Jack Black', nickname: 'Jack',
                              date_of_birth: '10/08/1980',
                              candidate_formation: candidate_formation,
                              description: 'Lorem Ipsum is simply',
                              experience: 'Lorem ipsum dolor sit amet',
                              candidate: candidate3)
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
                              candidate_description: 'Experiencia com mais de 20 anos')
    job.subscriptions.create!(candidate: candidate3, 
                              candidate_description: 'Experiencia com mais de 20 anos')

    login_as(head_hunter, scope: :head_hunter)
    visit subscribers_job_path(job)
    first(".markup-candidate").click

    expect(has_css?('i.fas', count: 1)).to eq true
    expect(has_css?('i.far', count: 2)).to eq true
  end

  scenario 'unmarkup candidate' do
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
    job.subscriptions.create!(candidate: candidate, 
                              candidate_description: 'Experiencia com mais de 10 anos', 
                              markup: :highlighted)

    login_as(head_hunter, scope: :head_hunter)
    visit subscribers_job_path(job)
    find('.markup-candidate').click
    
    expect(page).to have_css("i.far")
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
    expect(page).not_to have_content('Alan Turing') 
  end
end