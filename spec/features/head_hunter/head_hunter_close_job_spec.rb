require 'rails_helper'

feature 'Headhunter close subscriptions' do
  scenario 'successfully' do
    hunter = create(:head_hunter)
    job = create(:job, title: 'Dev Jr', head_hunter: hunter)

    login_as hunter, scope: :head_hunter
    visit root_path
    click_on 'Vagas cadastradas'
    click_on 'Dev Jr'
    click_on 'Encerrar inscrições'

    expect(page).to have_content('Inscrições encerradas com sucesso')
    job.reload
    expect(job.status).to eq('inactive')
    expect(page).not_to have_link('Encerrar inscrições')
  end

  scenario 'candidates cant see jobs with subscriptions closed' do
    hunter = create(:head_hunter)
    create(:job, title: 'Dev Ruby', head_hunter: hunter, status: :active)
    create(:job, title: 'Dev Java', head_hunter: hunter,
                 status: :inactive)
    candidate = create(:candidate)
    create(:candidate_profile, candidate: candidate)

    login_as(candidate, scope: :candidate)
    visit root_path

    expect(page).to have_link('Dev Ruby')
    expect(page).not_to have_link('Dev Java')
  end

  scenario 'candidates cant apply for closed jobs' do
    hunter = create(:head_hunter)
    job = create(:job, title: 'Dev Ruby', head_hunter: hunter,
                       status: :inactive)
    candidate = create(:candidate)
    create(:candidate_profile, candidate: candidate)

    login_as(candidate, scope: :candidate)
    visit job_path(job)
    click_on 'Candidatar-me'

    expect(page).to have_content(
      'As inscrições para essa vaga foram encerradas'
    )
    expect(current_path).to eq(root_path)
  end

  scenario 'headhunter must be logged' do
    job = create(:job)

    visit job_path(job)

    expect(page).to have_content(
      'Você não tem autorização para acessar essa página'
    )
  end

  scenario 'should exist the job' do
    hunter = create(:head_hunter)

    login_as hunter, scope: :head_hunter
    visit job_path(id: 1)

    expect(page).to have_content('Objeto não encontrado')
  end
end
