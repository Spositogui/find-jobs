require 'rails_helper'
require 'date'

feature 'Head hunter sends messages to candidates' do
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
    current_date = DateTime.now.strftime("%d/%m/%Y às %H:%M")

    login_as(head_hunter, scope: :head_hunter)
    visit root_path
    click_on 'Vagas cadastradas'
    click_on 'Dev Jr'
    click_on 'Ver candidatos'
    click_on candidate.candidate_profile.name
    click_on 'Comentar'
 
    fill_in 'Mensagem', with: 'Ac lobortis placerat egestas, ornare.'
    click_on 'Enviar'

    expect(current_path).to eq(candidate_profile_path(candidate))
    expect(page).to have_content('Comentário criado com sucesso.')
    expect(page).to have_content('Comentários:')
    expect(page).to have_content('Ac lobortis placerat egestas, ornare.')
    expect(page).to have_content(current_date) 
    expect(page).not_to have_content('Editar perfil')
  end

  scenario 'the message cant be blank' do
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
    visit candidate_profile_path(candidate)
    click_on 'Comentar'
    click_on 'Enviar'

    expect(page).to have_content('Mensagem não pode ficar em branco')
  end

  scenario 'more than one comment' do
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
    Comment.create!(candidate: candidate, head_hunter: head_hunter, 
                    message: 'At pellentesque mi egestas, eros.')
    Comment.create!(candidate: candidate, head_hunter: head_hunter, 
                    message: 'Velit quisque fames lacinia, aenean.')

    login_as(head_hunter, scope: :head_hunter)
    visit candidate_profile_path(candidate)
    
    expect(page).to have_content('At pellentesque mi egestas, eros.')
    expect(page).to have_content('Velit quisque fames lacinia, aenean.')
  end

  scenario 'see another headhunter comments' do
    candidate_formation = CandidateFormation.create!(name: 'Cursando superior')
    candidate = Candidate.create!(email: 'candi@cand.com', password: '123456')
    CandidateProfile.create!(name: 'Alan Turing', nickname: 'Alan',
                            date_of_birth: '02/05/1994',
                            candidate_formation: candidate_formation,
                            description: 'Lorem Ipsum is simply',
                            experience: 'Lorem ipsum dolor sit amet',
                            candidate: candidate)
    head_hunter = HeadHunter.create!(email: 'head@code.com', password: '123456')
    head_hunter2 = HeadHunter.create!(email: 'hunter@code.com', password: '123456')
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
    Comment.create!(candidate: candidate, head_hunter: head_hunter, 
                    message: 'At pellentesque mi egestas, eros.')

    login_as(head_hunter2, scope: :head_hunter)
    visit candidate_profile_path(candidate)

    expect(page).to have_content('At pellentesque mi egestas, eros.')
  end

  scenario 'must be logged' do
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
    Comment.create!(candidate: candidate, head_hunter: head_hunter, 
                    message: 'At pellentesque mi egestas, eros.')

    visit candidate_profile_path(candidate)

    expect(page).to have_content('Para continuar, faça login ou registre-se')
  end
end