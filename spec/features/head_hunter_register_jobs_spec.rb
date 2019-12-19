require 'rails_helper'

feature 'Head hunter register new jobs' do
	scenario 'successfully' do
		head_hunter = HeadHunter.create!(email:'te@gmail.com', password: '123456')
		ExperienceLevel.create!(name: 'Júnior')
		HiringType.create!(name: 'PJ')

		login_as(head_hunter, scope: :head_hunter)
		visit root_path
		click_on I18n.t('vacancies')
		click_on I18n.t('register_new_job')

		fill_in I18n.t('job.title'), with: 'Dev Ruby'
		fill_in I18n.t('job.job_description'), 
									with: 'Dolore dolor qui incididunt ea tempor in adipisicing in.'
		fill_in I18n.t('job.desired_skills'), 
									with: 'Et ut aliquip enim veniam commodo aliquip commodo ad amet in elit culpa est.'
		fill_in I18n.t('job.salary'), with: '2500.00'
		select 'Júnior', from: I18n.t('job.experience_level')
		select 'PJ', from: I18n.t('job.hiring_type')
		fill_in I18n.t('job.address'), with: 'Av. Paulista, nº 2000'
		select 'Sim', from: 'home_office'
		fill_in I18n.t('job.registration_end_date'), with: 5.days.from_now
		click_on I18n.t('register')

		expect(page).to have_content('Dev Ruby')
		expect(page).to have_content("#{I18n.t('job.job_description')}: Dolore dolor qui incididunt ea tempor in adipisicing in.")
		expect(page).to have_content("#{I18n.t('job.desired_skills')}: Et ut aliquip enim veniam "\
																"commodo aliquip commodo ad amet in elit culpa est.")
		expect(page).to have_content("#{I18n.t('job.salary')}: R$ 2.500,00")
		expect(page).to have_content("#{I18n.t('job.experience_level')}: Jú")
		expect(page).to have_content("#{I18n.t('job.hiring_type')}: PJ")
		expect(page).to have_content("#{I18n.t('job.address')}: Av. Paulista, nº 2000")
		expect(page).to have_content("#{I18n.t('job.home_office')}: Sim")
		expect(page).to have_content("#{I18n.t('job.registration_end_date')}: "\
																"#{5.days.from_now.strftime('%d/%m/%Y')}")
	end

	scenario 'and back to jobs index' do
		head_hunter = HeadHunter.create!(email:'te@gmail.com', password: '123456')
		ExperienceLevel.create!(name: 'Júnior')
		HiringType.create!(name: 'PJ')

		login_as(head_hunter, scope: :head_hunter)
		visit new_job_path

		fill_in I18n.t('job.title'), with: 'Dev Ruby'
		fill_in I18n.t('job.job_description'), 
									with: 'Dolore dolor qui incididunt ea tempor in adipisicing in.'
		fill_in I18n.t('job.desired_skills'), 
									with: 'Et ut aliquip enim veniam commodo aliquip commodo ad amet in elit culpa est.'
		fill_in I18n.t('job.salary'), with: '2500.00'
		select 'Júnior', from: I18n.t('job.experience_level')
		select 'PJ', from: I18n.t('job.hiring_type')
		fill_in I18n.t('job.address'), with: 'Av. Paulista, nº 2000'
		select 'Sim', from: 'home_office'
		fill_in I18n.t('job.registration_end_date'), with: 5.days.from_now
		click_on I18n.t('register')
		click_on I18n.t('back')

		expect(current_path).to eq(jobs_path)
	end

	scenario 'and all fields must be fill in' do
		head_hunter = HeadHunter.create!(email:'te@gmail.com', password: '123456')

		login_as(head_hunter, scope: :head_hunter)
		visit new_job_path
		click_on I18n.t('register')

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

		expect(current_path).to eq(new_head_hunter_session_path)
	end

	scenario 'and must be a headhunter user' do
		candidate = Candidate.create!(email: 'candidate1@test.com', password: '123456')

		login_as(candidate, scope: :candidate)
		visit new_job_path

		expect(current_path).to eq(new_head_hunter_session_path)
	end

	scenario 'and just headhunter user can see link for jobs' do
		visit root_path

		expect(page).not_to have_link(I18n.t('vacancies'))
	end
end	



