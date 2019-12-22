class HomeController < ApplicationController
  def index
    @jobs = Job.where(status: :active)
  end
end