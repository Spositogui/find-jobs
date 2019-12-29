require 'rails_helper'

feature  'HeadHunter submit proposal to candidates' do
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
    click_on 'Criar proposta'

    select 'Alan Turing', from: 'Candidato'
    fill_in 'Nome da empresa', with: 'Code'
    fill_in 'Data de ínicio', with: 2.days.from_now
    fill_in 'Salário', with: '2200.00'
    fill_in 'Benefícios', with: 'Duis luctus rhoncus consequat, arcu.'
    fill_in 'Cargo', with: 'Dev Jr'
    fill_in 'Responsabilidades', with: 'Nunc nulla tristique posuere, congue.'
    select 'PJ', from: 'Tipo de contratação'
    fill_in 'Outros', with: 'Porttitor turpis lorem nibh, at.'
    click_on 'Enviar proposta'
  end
end