class ProposalsController < ApplicationController
  before_action :authenticate_head_hunter!
  load_and_authorize_resource

  def new
    @proposal = Proposal.new
    @job = Job.find(params[:job_id])
    @subscriptions = @job.subscriptions
    @hiring_type = HiringType.all
  end
  
  def create
  end

  private

  def proposal_params
    params.require(:proposal).permit(:company_name, :start_date, :salary,
                                     :benefits, :role, :responsabilities,
                                     :hiring_type_id, :others)
  end
end