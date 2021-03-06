class JobsController < ApplicationController
	load_and_authorize_resource
	before_action :authenticate_head_hunter!, only: %i[index new create]
	before_action :set_job, only: %i[show subscription cofirmed_subscription close_subscriptions]

	def index
		@jobs = Job.where('head_hunter_id = ?', current_head_hunter.id)
	end

	def show
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

	def close_subscriptions
		@job.inactive!
		redirect_to @job, notice: 'Inscrições encerradas com sucesso'
	end

	def cofirmed_subscription
		@job.subscriptions.build(candidate: current_candidate, 
														candidate_description: params[:subscription][:candidate_description] ) 
		if @job.save
			flash[:notice] = 'Parabéns, você acaba de se inscrever para essa vaga.'
			redirect_to @job
		else
			@subscription = Subscription.new
			render :subscription
		end
	end

	def search 
		@jobs = Job.where("title = ?", params[:q]).
			or(Job.where('description LIKE ?', "%#{params[:q]}%"))

		render partial: 'search'
	end

	def subscribers
		@job = Job.find(params[:id])
		@subscriptions = @job.subscriptions
	end

	def subscription 
		return @subscription = Subscription.new unless @job.inactive?
		redirect_to root_path, 
			notice: 'As inscrições para essa vaga foram encerradas'
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

	def set_job
		@job = Job.find(params[:id])
	end
end