class ProposalsController < ApplicationController
  before_action :authenticate_head_hunter!, unless: :candidate_signed_in?
  load_and_authorize_resource

  def new
    @subscription = Subscription.find(params[:subscription_id])
    @proposal = Proposal.new
    @hiring_type = HiringType.all
  end

  def create
    @subscription = Subscription.find(params[:subscription_id])
    @proposal = Proposal.new(proposal_params)
    @proposal.subscription = @subscription
    
    if @proposal.save
      flash[:notice] = 'Proposta enviada com sucesso.'
      redirect_to subscribers_job_path(@subscription.job)
    else
      @hiring_type = HiringType.all
      render :new
    end
  end

  private

  def proposal_params
    params.require(:proposal).permit(:company_name, :start_date, :salary,
                                     :benefits, :role, :responsabilities,
                                     :hiring_type_id, :others)
  end
end