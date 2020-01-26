require 'rails_helper'

feature 'Candidate edits your profile' do
  scenario 'successfully' do
    candidate = Candidate.create!(email: 'candi@cand.com', password: '123456')
    candidate_formation = CandidateFormation.create!(name: 'Cursando superior')
    CandidateFormation.create!(name: 'Superior completo')
    CandidateProfile.create!(name: 'Alan Turing', nickname: 'Alan',
                                                date_of_birth: '02/05/1994',
                                                candidate_formation: candidate_formation,
                                                description: 'Lorem Ipsum is simply',
                                                experience: 'Lorem ipsum dolor sit amet',
                                                candidate: candidate)

    login_as(candidate, scope: :candidate)
    visit root_path
    click_on 'candi@cand.com'
    click_on 'Perfil'
    click_on 'Editar perfil'

    fill_in 'Nome completo', with: 'Turing Alan'
    fill_in 'Nome social', with: 'Turing'
    select 'Superior completo', from: 'Formação'
    click_on 'Enviar'

    expect(page).to have_content('Perfil atualizado com sucesso.')
    expect(page).to have_content('Nome: Turing Alan')
    expect(page).to have_content('Nome social: Turing')
    expect(page).to have_content('Data de nascimento: 02/05/1994')
    expect(page).to have_content('Formação: Superior completo')
    expect(page).to have_content('Descrição: Lorem Ipsum is simply')
    expect(page).to have_content('Experiência: Lorem ipsum dolor sit amet')
  end

  scenario 'fields cant be blank' do
    candidate = Candidate.create!(email: 'candi@cand.com', password: '123456')
    candidate_formation = CandidateFormation.create!(name: 'Cursando superior')
    CandidateProfile.create!(name: 'Alan Turing', nickname: 'Alan',
                                                date_of_birth: '02/05/1994',
                                                candidate_formation: candidate_formation,
                                                description: 'Lorem Ipsum is simply',
                                                experience: 'Lorem ipsum dolor sit amet',
                                                candidate: candidate)

    login_as(candidate, scope: :candidate)
    visit edit_candidate_profile_path(candidate.candidate_profile)
    fill_in 'Nome completo', with: ''
    fill_in 'Descrição', with: ''
    click_on 'Enviar'

    expect(page).to have_content('Nome completo não pode ficar em branco')
    expect(page).to have_content('Descrição não pode ficar em branco')
  end

  scenario 'must be logged' do
    candidate = Candidate.create!(email: 'candi@cand.com', password: '123456')
    candidate_formation = CandidateFormation.create!(name: 'Cursando superior')
    CandidateProfile.create!(name: 'Alan Turing', nickname: 'Alan',
                                                date_of_birth: '02/05/1994',
                                                candidate_formation: candidate_formation,
                                                description: 'Lorem Ipsum is simply',
                                                experience: 'Lorem ipsum dolor sit amet',
                                                candidate: candidate)

    visit edit_candidate_profile_path(candidate.candidate_profile)

    expect(current_path).to eq(new_candidate_session_path)  
  end

  scenario 'back to home page' do
    candidate = Candidate.create!(email: 'candi@cand.com', password: '123456')
    candidate_formation = CandidateFormation.create!(name: 'Cursando superior')
    CandidateProfile.create!(name: 'Alan Turing', nickname: 'Alan',
                                                date_of_birth: '02/05/1994',
                                                candidate_formation: candidate_formation,
                                                description: 'Lorem Ipsum is simply',
                                                experience: 'Lorem ipsum dolor sit amet',
                                                candidate: candidate)

    login_as(candidate, scope: :candidate)
    visit edit_candidate_profile_path(candidate.candidate_profile)
    click_on 'Voltar'

    expect(current_path).to eq(root_path)  
  end
end