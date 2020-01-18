class SubscriptionsController < ApplicationController
  load_and_authorize_resource
  before_action :authenticate_candidate!, unless: :head_hunter_signed_in?
  
  def index
    @candidate = current_candidate
    @vacancies = @candidate.jobs.all
  end

  def highlight_candidate
    @subscription = Subscription.find(params[:id])
    if @subscription.unhighlighted?
      @subscription.highlighted!
    elsif @subscription.highlighted?
      @subscription.unhighlighted!
    end
    redirect_to subscribers_job_path(@subscription.job_id)
  end
end