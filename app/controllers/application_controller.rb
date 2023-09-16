class ApplicationController < ActionController::API
  # This is just for API-based applications, remove for full Rails applications
  include ActionController::Cookies

  before_action :authorized

  def current_user
    @current_user ||= User.find(session[:user_id]) if session[:user_id]
  end

  def logged_in?
    !!current_user
  end

  def authorized
    render json: { status: 'error', message: 'Please log in' }, status: :unauthorized unless logged_in?
  end
end
