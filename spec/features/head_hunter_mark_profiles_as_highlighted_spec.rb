require 'rails_helper'

feature 'HeadHunter mark profiles as highlighted' do
  xscenario 'successfully' do
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
    find(:css, 'i.far.fa-star').click
    
    expect(page).to have_css("svg.active")
    #expect(has_css?('i.far', count: 1)).to eq true
  end
end