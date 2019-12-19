class JobsController < ApplicationController
	before_action :authenticate_head_hunter!
	load_and_authorize_resource

	def index
	end

	def show
		@job = Job.find(params[:id])
	end

	def new
		@job = Job.new
		@experience_levels = ExperienceLevel.all
		@hiring_types = HiringType.all
	end

  def create
		@job = Job.new(job_params)	
		@job.home_office = params[:home_office]
		if @job.save
			redirect_to @job
		else
			@experience_levels = ExperienceLevel.all
			@hiring_types = HiringType.all
			render :new
		end
	end

	private

	def job_params
		params.require(:job).permit(:title, :description,
																:skills_description,
																:salary, :experience_level_id,
																:hiring_type_id, :address,
																:home_office,
																:registration_end_date)
	end
end