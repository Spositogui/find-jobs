require 'rails_helper'

feature 'Head hunter register new jobs' do
	scenario 'successfully' do
		head_hunter = HeadHunter.create!(email:'te@gmail.com', password: '123456')
		ExperienceLevel.create!(name: 'Júnior')
		HiringType.create!(name: 'PJ')

		login_as(head_hunter, scope: :head_hunter)
		visit root_path
		click_on 'Vagas cadastradas'
		click_on 'Registrar nova vaga'

		fill_in 'Titulo da vaga', with: 'Dev Ruby'
		fill_in 'Descrição da vaga', 
									with: 'Dolore dolor qui incididunt ea tempor in adipisicing in.'
		fill_in 'Habilidades desejadas', 
									with: 'Et ut aliquip enim veniam commodo aliquip commodo ad amet in elit culpa est.'
		fill_in 'Salário', with: '2500.00'
		select 'Júnior', from: 'Nível de experiência'
		select 'PJ', from: 'Tipo de contratação'
		fill_in 'Endereço', with: 'Av. Paulista, nº 2000'
		select 'Sim', from: 'home_office'
		fill_in 'Data de expiração da vaga', with: 5.days.from_now
		click_on 'Cadastrar'

		expect(page).to have_content('Dev Ruby')
		expect(page).to have_content("Descrição da vaga: Dolore dolor qui incididunt ea tempor in adipisicing in.")
		expect(page).to have_content("Habilidades desejadas: Et ut aliquip enim veniam "\
																"commodo aliquip commodo ad amet in elit culpa est.")
		expect(page).to have_content("Salário: R$ 2.500,00")
		expect(page).to have_content("Nível de experiência: Jú")
		expect(page).to have_content("Tipo de contratação: PJ")
		expect(page).to have_content("Endereço: Av. Paulista, nº 2000")
		expect(page).to have_content("Remoto: Sim")
		expect(page).to have_content("Data de expiração da vaga: #{5.days.from_now.strftime('%d/%m/%Y')}")
	end

	scenario 'and back to jobs index' do
		head_hunter = HeadHunter.create!(email:'te@gmail.com', password: '123456')
		ExperienceLevel.create!(name: 'Júnior')
		HiringType.create!(name: 'PJ')

		login_as(head_hunter, scope: :head_hunter)
		visit new_job_path

		fill_in 'Titulo da vaga', with: 'Dev Ruby'
		fill_in 'Descrição da vaga', 
									with: 'Dolore dolor qui incididunt ea tempor in adipisicing in.'
		fill_in 'Habilidades desejadas', 
									with: 'Et ut aliquip enim veniam commodo aliquip commodo ad amet in elit culpa est.'
		fill_in 'Salário', with: '2500.00'
		select 'Júnior', from: 'Nível de experiência'
		select 'PJ', from: 'Tipo de contratação'
		fill_in 'Endereço', with: 'Av. Paulista, nº 2000'
		select 'Sim', from: 'home_office'
		fill_in 'Data de expiração da vaga', with: 5.days.from_now
		click_on 'Cadastrar'
	  click_on 'Voltar'

		expect(current_path).to eq(root_path)
	end

	scenario 'and all fields must be fill in' do
		head_hunter = HeadHunter.create!(email:'te@gmail.com', password: '123456')

		login_as(head_hunter, scope: :head_hunter)
		visit new_job_path
		click_on 'Cadastrar'

		expect(page).to have_content("Titulo da vaga não pode ficar em branco")
		expect(page).to have_content("Descrição da vaga não pode ficar em branco")
		expect(page).to have_content("Habilidades desejadas não pode ficar em branco")
		expect(page).to have_content("Salário não pode ficar em branco")
		expect(page).to have_content("Nível de experiência não pode ficar em branco")
		expect(page).to have_content("Tipo de contratação não pode ficar em branco")
		expect(page).to have_content("Endereço não pode ficar em branco")
		expect(page).to have_content("Data de expiração da vaga não pode ficar em branco")
	end

	scenario 'and must be logged' do
		visit new_job_path

		expect(page).to have_content('Você não tem autorização para acessar essa página')
	end

	scenario 'and must be a headhunter user' do
		candidate = Candidate.create!(email: 'candidate1@test.com', password: '123456')

		login_as(candidate, scope: :candidate)
		visit new_job_path

		expect(page).to have_content('Você não tem autorização para acessar essa página')
	end

	scenario 'and just headhunter user can see link for jobs' do
		visit root_path

		expect(page).not_to have_link(I18n.t('vacancies'))
	end
end	



