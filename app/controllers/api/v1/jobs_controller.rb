class Api::V1::JobsController < Api::V1::ApiController
  def index
    @jobs = Job.all
    return render json: 'Not implemented', status: :not_implemented unless @jobs.any?
    render json: @jobs
  end
end