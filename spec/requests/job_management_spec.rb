require 'rails_helper'

describe 'Job Management' do
  context 'index' do
    it 'renders correctly' do
      head_hunter = create(:head_hunter)
      job = create(:job, title: 'Dev Jr', head_hunter: head_hunter)
      job2 = create(:job, title: 'Dev Pleno', head_hunter: head_hunter)
      job3 = create(:job, title: 'Dev Senior', head_hunter: head_hunter)
      
      get api_v1_jobs_path
      json = JSON.parse(response.body, symbolize_names: true)

      expect(response).to have_http_status(:ok)
      expect(json[0][:title]).to eq(job.title)
      expect(json[1][:title]).to eq(job2.title)
      expect(json[2][:title]).to eq(job3.title)
    end

    it 'not implemented' do
      get api_v1_jobs_path

      expect(response).to have_http_status(:not_implemented)
      expect(response.body).to eq('Not implemented')
    end
  end

  context 'show' do
    it 'render job correctly' do
      job = create(:job)

      get api_v1_job_path(job)
      json = JSON.parse(response.body, symbolize_names: true)

      expect(response).to have_http_status(:ok)
      expect(json[:title]).to eq(job.title)
      expect(json[:description]).to eq(job.description)
      expect(json[:skills_description]).to eq(job.skills_description)
      expect(json[:salary]).to eq(job.salary.to_s)
      expect(json[:experience_level_id]).to eq(job.experience_level_id)
      expect(json[:hiring_type_id]).to eq(job.hiring_type_id)
      expect(json[:address]).to eq(job.address)
      expect(json[:home_office]).to eq(job.home_office)
    end

    it 'model not found' do
      get api_v1_job_path(id: 999)

      expect(response).to have_http_status(:not_found)
      expect(response.body).to eq('Object not found') 
    end
  end

  context 'create' do
    it 'create correctly' do
      head_hunter = create(:head_hunter)
      experience = create(:experience_level)
      hiring = create(:hiring_type)

      expect {
        post api_v1_jobs_path, params: { job: { title: 'Dev Ruby',
                                                description: 'Vestibulum ornare non',
                                                skills_description: 'Nulla ac elementum quam.',
                                                salary: 2500.0,
                                                experience_level_id: experience.id,
                                                hiring_type_id: hiring.id,
                                                address: 'Av. Ruby, nº 263',
                                                registration_end_date: 10.days.from_now,
                                                head_hunter_id: head_hunter.id } }

        json = JSON.parse(response.body, symbolize_names: true)

        expect(response).to have_http_status(:ok)
        expect(json[:title]).to eq('Dev Ruby')
        expect(json[:description]).to eq('Vestibulum ornare non')
        expect(json[:skills_description]).to eq('Nulla ac elementum quam.')
        expect(json[:salary]).to eq('2500.0')
        expect(json[:experience_level_id]).to eq(experience.id)
        expect(json[:hiring_type_id]).to eq(hiring.id)
        expect(json[:address]).to eq('Av. Ruby, nº 263')
        expect(json[:registration_end_date]).to eq(10.days.from_now.strftime('%Y-%m-%d'))
      }.to change(Job, :count).by(1)
    end

    it 'not create' do
      expect {
        post api_v1_jobs_path, params: { job: {}}

        expect(response).to have_http_status(:precondition_failed)
        expect(response.body).to eq('Inexistent parameters')
      }.to change(Job, :count).by(0)
    end

    it 'mandatory field not send' do
      head_hunter = create(:head_hunter)

      post api_v1_jobs_path, params: { job: { title: 'Dev Ruby',
                                              description: 'Vestibulum ornare non',
                                              skills_description: 'Nulla ac elementum quam.',
                                              salary: 2500.0,
                                              experience_level_id: nil,
                                              hiring_type_id: nil,
                                              address: 'Av. Ruby, nº 263',
                                              registration_end_date: 10.days.from_now,
                                              head_hunter_id: head_hunter.id } }
      json = JSON.parse(response.body, symbolize_names: true)

      expect(response).to have_http_status(:precondition_failed)
      expect(json[:message]).to include('Nível de experiência não pode ficar em branco')
      expect(json[:message]).to include('Tipo de contratação não pode ficar em branco')    
    end
  end

  context 'update' do
    it 'edit job correctly' do
      job = create(:job, title: 'Dev Jr', salary: 2000.0)

      expect {
        patch api_v1_job_path(job), params: { job: { title: 'Analista pleno',
                                                     salary: 4000.0 } }

        expect(response).to have_http_status(:ok)
        job.reload
        expect(job.title).to eq('Analista pleno')
        expect(job.salary.to_s).to eq('4000.0')  
      }.to change(Job, :count).by(0)
    end

    it 'model not found' do
      patch api_v1_job_path(id: 999)
      
      expect(response).to have_http_status(:not_found)
      expect(response.body).to eq('Object not found')
    end

    it 'mandatory fields not send' do
      hiring = create(:hiring_type, name: 'CLT')
      job = create(:job, hiring_type: hiring)

      patch api_v1_job_path(job), params: { job: { hiring_type_id: nil } }
      json = JSON.parse(response.body, symbolize_names: true)
      
      expect(response).to have_http_status(:precondition_failed)
      expect(json[:message]).to include('Tipo de contratação não pode ficar em branco')
      job.reload
      expect(job.hiring_type_id).not_to eq(nil)  
    end

    it 'fields cannot be blank' do
      head_hunter = create(:head_hunter, email: 'code@example.com')
      experience = create(:experience_level, name: 'Júnior')
      hiring = create(:hiring_type, name: 'CLT')
      job = create(:job, title: 'Dev Ruby', description: 'Vestibulum ornare non',
                         skills_description: 'Nulla ac elementum quam.',
                         salary: 2500.0, experience_level_id: experience.id,
                         hiring_type_id: hiring.id, address: 'Av. Ruby, nº 263',
                         registration_end_date: 10.days.from_now,
                         head_hunter_id: head_hunter.id)

      patch api_v1_job_path(job), params: { job: { title: '', description: '',
                                                   skills_description: '',
                                                   salary: '', experience_level_id: '',
                                                   hiring_type_id: '', head_hunter_id: '',
                                                   registration_end_date: '' } }
      json = JSON.parse(response.body, symbolize_names: true)

      expect(response).to have_http_status(:precondition_failed)
      expect(json[:message]).to include('Titulo da vaga não pode ficar em branco')
      expect(json[:message]).to include('Descrição da vaga não pode ficar em branco')
      expect(json[:message]).to include('Nível de experiência não pode ficar em branco')
      expect(json[:message]).to include('Tipo de contratação não pode ficar em branco') 
    end
  end
end