require 'rails_helper'

feature 'Headhunter register a new account' do
  scenario 'successfully' do
	visit root_path
	click_on 'Cadastrar-se'
	click_on 'Como empresa'
	
	fill_in 'Email', with: 'julio@campus.com'
	fill_in 'Senha', with: '123456'
	fill_in 'Confirme sua senha', with: '123456'
	click_on 'Inscrever-se'

	expect(current_path).to eq root_path
	expect(page).to have_content('Bem vindo! Você realizou seu registro com sucesso.')
	expect(page).to have_content('julio@campus.com')
	expect(page).to have_link('Vagas cadastradas')
	expect(page).to have_link('Sair')
	expect(page).not_to have_link('Cadastrar-se')
	expect(page).not_to have_link('Entrar')
  end

  scenario 'and all fields must be fill in' do
	visit new_head_hunter_registration_path
	click_on 'Inscrever-se'

	expect(page).to have_content('Email não pode ficar em branco')
	expect(page).to have_content('Senha não pode ficar em branco')
  end

  scenario 'and email must be unique' do
	head_hunter = HeadHunter.create!(email: 'test@campus.com',
							password: '123456')

	visit new_head_hunter_registration_path
	fill_in 'Email', with: head_hunter.email
	fill_in 'Senha', with: '654321'
	fill_in 'Confirme sua senha', with: '654321'
	click_on 'Inscrever-se'

	expect(page).to have_content('Email já está em uso')
  end


	scenario 'and email must be valid' do
		visit new_head_hunter_registration_path
		fill_in 'Email', with: 'juliocampus'
		fill_in 'Senha', with: '123456'
		fill_in 'Confirme sua senha', with: '123456'
		click_on 'Inscrever-se'

		expect(page).to have_content('Email não é válido')
	end

	scenario 'and password must be valid' do
    visit new_head_hunter_registration_path
		fill_in 'Email', with: 'julio@campus.com'
		fill_in 'Senha', with: '@#32'
		fill_in 'Confirme sua senha', with: '@#32'
		click_on 'Inscrever-se'

		expect(page).to have_content('Senha é muito curto (mínimo: 6 caracteres)')
	end

end