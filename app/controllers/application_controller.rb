class ApplicationController < ActionController::Base
  skip_forgery_protection

  rescue_from ActionController::ParameterMissing, ActiveModel::ValidationError, ArgumentError, NoMethodError do
    render_bad_request
  end

  rescue_from ActiveRecord::RecordNotFound do
    render_not_found
  end

  def render_not_found
    render json: { message: 'Record not Found' }, status: :not_found
  end

  def render_bad_request(error_message: 'Bad Request')
    render json: { message: error_message }, status: :unprocessable_entity
  end
end
