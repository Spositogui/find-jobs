require 'rails_helper'

feature  'HeadHunter submit proposal to candidates' do
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
    click_on 'Criar proposta'

    fill_in 'Nome da empresa', with: 'Code'
    fill_in 'Data de ínicio', with: 2.days.from_now
    fill_in 'Salário', with: '2200.00'
    fill_in 'Benefícios', with: 'Duis luctus rhoncus consequat, arcu.'
    fill_in 'Cargo', with: 'Dev Jr'
    fill_in 'Responsabilidades', with: 'Nunc nulla tristique posuere, congue.'
    select 'PJ', from: 'Tipo de contratação'
    fill_in 'Outros', with: 'Porttitor turpis lorem nibh, at.'
    click_on 'Enviar proposta'

    expect(page).to have_content('Proposta enviada com sucesso.')
    expect(current_path).to eq(subscribers_job_path(job))
    expect(page).to have_link('Proposta enviada')
    expect(page).not_to have_content('Criar proposta')
  end

  scenario 'fields must be filled' do
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
    subscription = Subscription.create!(candidate: candidate, job: job,
                                        candidate_description: 'Experiencia com mais de 10 anos')

    login_as(head_hunter, scope: :head_hunter)
    visit new_subscription_proposal_path(subscription)
    click_on 'Enviar proposta'

    expect(page).to have_content('Você deve corrigir os seguintes erros:')
    expect(page).to have_content('Nome da empresa não pode ficar em branco')
    expect(page).to have_content('Data de ínicio não pode ficar em branco')
    expect(page).to have_content('Salário não pode ficar em branco')
    expect(page).to have_content('Benefícios não pode ficar em branco')
    expect(page).to have_content('Cargo não pode ficar em branco')
    expect(page).to have_content('Responsabilidades não pode ficar em branco')
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
    subscription = Subscription.create!(candidate: candidate, job: job,
                                        candidate_description: 'Experiencia com mais de 10 anos')

    visit new_subscription_proposal_path(subscription)

    expect(page).to have_content('Para continuar, faça login ou registre-se.')
  end

  scenario 'must be a headhunter user' do
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
    subscription = Subscription.create!(candidate: candidate, job: job,
                                        candidate_description: 'Experiencia com mais de 10 anos')

    login_as(candidate, scope: :candidate)
    visit new_subscription_proposal_path(subscription)

    expect(page).to have_content('Você não tem autorização para acessar essa página')
  end
end