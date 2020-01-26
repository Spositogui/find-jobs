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

    it 'not found' do
      get api_v1_jobs_path

      expect(response).to have_http_status(:not_implemented)
      expect(response.body).to eq('Not implemented')
    end
  end
end