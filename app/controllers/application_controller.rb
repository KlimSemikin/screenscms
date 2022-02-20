class ApplicationController < ActionController::API
  def current_user
    # session[:user_id] = 2
    # return unless session[:user_id]
    @current_user ||= User.find(2)
  end

  def current_ability
    @current_ability ||= Ability.new(current_user)
  end

  rescue_from CanCan::AccessDenied do |exception|
    render json: { error: exception.message }, status: :forbidden
  end

  rescue_from ActiveRecord::RecordNotFound do |exception|
    render json: { error: exception.message }, status: :not_found
  end
end
