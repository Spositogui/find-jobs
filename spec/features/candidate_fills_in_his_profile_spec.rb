require 'rails_helper'

feature 'Candidate fills in profile' do
  scenario 'successfuly' do
    candidate = Candidate.create!(email: 'candidate@code.com', password: '123456')
    CandidateFormation.create!(name: 'Cursando ensino superior')

    login_as(candidate, scope: :candidate)
    visit root_path
    click_on 'candidate@code.com'
    click_on 'Perfil'
    
    fill_in 'Nome completo', with: 'Alan Turing'
    fill_in 'Nome social', with: 'Alan'
    fill_in 'Data de nascimento', with: '02/05/1994'
    select 'Cursando ensino superior', from: 'Formação'
    fill_in "Descrição",	with: 'Lorem Ipsum is simply dummy text of the printing'
    fill_in "Experiência", with: 'Lorem ipsum dolor sit amet, consectetur adipiscing.'
    page.attach_file('Foto', Rails.root.join('spec', 'support', 'avatar.png'))
    click_on 'Enviar'

    expect(page).to have_content('Perfil criado com sucesso.')
    expect(page).to have_css("img[src*='avatar.png']")  
    expect(page).to have_content('Nome: Alan Turing')
    expect(page).to have_content('Nome social: Alan')
    expect(page).to have_content('Data de nascimento: 02/05/1994')
    expect(page).to have_content('Formação: Cursando ensino superior')
    expect(page).to have_content('Descrição: Lorem Ipsum is simply dummy text of the printing')
    expect(page).to have_content('Experiência: Lorem ipsum dolor sit amet, consectetur adipiscing.')  
  end

  scenario 'can see profile if it already exists' do
    candidate = Candidate.create!(email: 'candi@cand.com', password: '123456')
    candidate_formation = CandidateFormation.create!(name: 'Cursando superior')
    candidate_profile = CandidateProfile.create!(name: 'Alan Turing', nickname: 'Alan',
                                                date_of_birth: '02/05/1994',
                                                candidate_formation: candidate_formation,
                                                description: 'Lorem Ipsum is simply',
                                                experience: 'Lorem ipsum dolor sit amet',
                                                candidate: candidate)

    login_as(candidate, scope: :candidate)
    visit root_path
    click_on 'candi@cand.com'
    click_on 'Perfil'

    expect(current_path).to eq(candidate_profile_path(candidate.candidate_profile))
    expect(page).to have_content('Nome: Alan Turing')
    expect(page).to have_content('Nome social: Alan')
    expect(page).to have_content('Data de nascimento: 02/05/1994')
  end

  scenario 'all fields must be filled' do
    candidate = Candidate.create!(email: 'candi@cand.com', password: '123456')

    login_as(candidate, scope: :candidate)
    visit new_candidate_profile_path
    click_on 'Enviar'
    
    expect(page).to have_content('Nome completo não pode ficar em branco')
    expect(page).to have_content('Nome completo é muito curto (mínimo: 2 caracteres)')
    expect(page).to have_content('Data de nascimento não pode ficar em branco')
    expect(page).to have_content('Descrição não pode ficar em branco')
    expect(page).to have_content('Formação é obrigatório(a)')
  end

  scenario 'must be logged' do
    visit new_candidate_profile_path

    expect(current_path).to eq(new_candidate_session_path)
  end

  scenario "redirected for profiling if you don't already have one" do
    candidate = Candidate.create!(email: 'candi@cand.com', password: '123456')
    
    visit root_path
    click_on 'Entrar'
    within('div#log-in') do
      click_on 'Como candidato'
    end

    fill_in 'Email', with: 'candi@cand.com'
    fill_in 'Senha', with: '123456'
    click_on 'Log in'

    expect(current_path).to eq(new_candidate_profile_path)
  end

  scenario 'and logged in and filled profile redirected to home' do
    candidate = Candidate.create!(email: 'candi@cand.com', password: '123456')
    candidate_formation = CandidateFormation.create!(name: 'Cursando superior')
    candidate_profile = CandidateProfile.create!(name: 'Alan Turing', nickname: 'Alan',
                                                date_of_birth: '02/05/1994',
                                                candidate_formation: candidate_formation,
                                                description: 'Lorem Ipsum is simply',
                                                experience: 'Lorem ipsum dolor sit amet',
                                                candidate: candidate)

    visit root_path
    click_on 'Entrar'
    within('div#log-in') do
      click_on 'Como candidato'
    end

    fill_in 'Email', with: 'candi@cand.com'
    fill_in 'Senha', with: '123456'
    click_on 'Log in'

    expect(current_path).to eq(root_path)
  end
end