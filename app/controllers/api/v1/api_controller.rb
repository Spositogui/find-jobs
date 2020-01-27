class Api::V1::ApiController < ActionController::API
  rescue_from ActiveRecord::RecordNotFound, with: :object_not_found

  def object_not_found
    render json: 'Object not found', status: :not_found
  end
end