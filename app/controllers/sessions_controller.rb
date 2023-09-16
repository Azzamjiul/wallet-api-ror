class SessionsController < ApplicationController
  skip_before_action :authorized, only: [:login]

  def login
    user = User.find_by(email: params[:email])
    
    if user && user.authenticate(params[:password])
      session[:user_id] = user.id
      render json: { status: 'logged in', user: user }, status: :ok
    else
      render json: { status: 'error', message: 'Invalid email or password' }, status: :unauthorized
    end
  end

  def logout
    session[:user_id] = nil
    render json: { status: 'logged out' }, status: :ok
  end
end
