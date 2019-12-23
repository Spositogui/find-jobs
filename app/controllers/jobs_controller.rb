class JobsController < ApplicationController
	load_and_authorize_resource
	before_action :authenticate_head_hunter!, only: [:index, :new, :create]

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
		@job.head_hunter = current_head_hunter
		if @job.save
			redirect_to @job
		else
			@experience_levels = ExperienceLevel.all
			@hiring_types = HiringType.all
			render :new
		end
	end

	def search 
		@jobs = Job.where(title: params[:q]).
			or(Job.where('description LIKE ?', "%#{params[:q]}%"))

		render partial: 'search'
	end

	private

	def job_params
		params.require(:job).permit(:title, :description,
																:skills_description,
																:salary, :experience_level_id,
																:hiring_type_id, :address,
																:home_office,
																:registration_end_date,
																:head_hunter_id)
	end
end