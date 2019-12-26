class SubscriptionsController < ApplicationController
  load_and_authorize_resource
  before_action :authenticate_candidate!
  
  def index
    @candidate = current_candidate
    @vacancies = @candidate.jobs.all
  end
end