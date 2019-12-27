class CommentsController < ApplicationController
  before_action :authenticate_head_hunter!
  load_and_authorize_resource

  def new
    @comment = Comment.new
    @candidate_profile = CandidateProfile.find(params[:candidate_profile_id])
  end

  def create
    @comment = Comment.new(comment_params)
    @candidate_profile = CandidateProfile.find(params[:candidate_profile_id])
    @comment.candidate = @candidate_profile.candidate 
    @comment.head_hunter = current_head_hunter
    
    if @comment.save
      redirect_to @candidate_profile, notice: 'Comentário criado com sucesso.'
    else
      @candidate = CandidateProfile.find(params[:candidate_profile_id])
      render :new
    end
  end

  private

  def comment_params
    params.require(:comment).permit(:message)
  end
end