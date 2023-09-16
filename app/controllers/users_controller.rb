class UsersController < ApplicationController
  def profile
    user = current_user

    if user
      render json: { message: 'Success', data: user }, status: :ok
    else
      render json: { error: 'Not logged in' }, status: :unauthorized
    end
  end
end
