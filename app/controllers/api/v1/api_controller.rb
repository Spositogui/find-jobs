class Api::V1::ApiController < ActionController::API
  rescue_from ActiveRecord::RecordNotFound, with: :object_not_found
  #/rescue_from ActiveRecord::RecordInvalid, with: :invalid_record

  def object_not_found
    render json: 'Object not found', status: :not_found
  end
end