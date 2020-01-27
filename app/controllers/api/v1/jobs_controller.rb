class Api::V1::JobsController < Api::V1::ApiController
  def index
    @jobs = Job.all
    return render json: 'Not implemented', status: :not_implemented unless @jobs.any?
    render json: @jobs
  end

  def show
    @job = Job.find(params[:id])
    render json: @job
  end

  def create
    return render json: 'Inexistent parameters', 
                  status: :precondition_failed unless params[:job].present? 

    @job = Job.new(params.require(:job).permit(:title, :description,
                                               :salary, :address,
                                               :skills_description,
                                               :experience_level_id,
                                               :hiring_type_id,
                                               :registration_end_date,
                                               :head_hunter_id))
  
    if @job.valid?
      @job.save!
      render json: @job
    else
      render json: {'message': @job.errors.full_messages}, status: :precondition_failed
    end
  end
end