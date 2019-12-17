require 'rails_helper'

feature 'Visitor signs up to apply for vacancies' do
	scenario 'successfully' do 
		visit root_path
		click_on 'Cadastrar-se'
		click_on 'Como candidato'

		fill_in 'Email', with: 'joao@gmail.com'
		fill_in 'Senha', with: '123456'
		fill_in 'Confirme sua senha', with: '123456'
		click_on 'Inscrever-se'

		expect(current_path).to eq root_path
		expect(page).to have_content('Bem vindo! Você realizou seu registro com sucesso.')
		expect(page).to have_content('joao@gmail.com')
		expect(page).to have_content('Sair')
		expect(page).not_to have_content('Cadastrar-se')
		expect(page).not_to have_content('Vagas cadastradas')
	end

	scenario 'and all fields muts be fill in' do
		visit new_candidate_registration_path
		click_on 'Inscrever-se'

		expect(page).to have_content('Email não pode ficar em branco')
  	expect(page).to have_content('Senha não pode ficar em branco')
	end

	scenario 'and email must be unique' do
		Candidate.create!(email: 'test@gmail.com', password: '123456')

		visit new_candidate_registration_path
		fill_in 'Email', with: 'test@gmail.com'
		fill_in 'Senha', with: '123456'
		fill_in 'Confirme sua senha', with: '123456'
		click_on 'Inscrever-se'

		expect(page).to have_content('Email já está em uso')
	end

  scenario 'and email must be valid' do
  	visit new_candidate_registration_path
  	fill_in 'Email', with: 'testgmail.com'
		fill_in 'Senha', with: '123456'
		fill_in 'Confirme sua senha', with: '123456'
		click_on 'Inscrever-se'

		expect(page).to have_content('Email não é válido')
	end

	scenario 'and password must be valid' do
		visit new_candidate_registration_path
  	fill_in 'Email', with: 'test@gmail.com'
		fill_in 'Senha', with: '123@$'
		fill_in 'Confirme sua senha', with: '123@$'
		click_on 'Inscrever-se'

		expect(page).to have_content('Senha é muito curto (mínimo: 6 caracteres)')
	end
end