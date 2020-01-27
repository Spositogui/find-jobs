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
end