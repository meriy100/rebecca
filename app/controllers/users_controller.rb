class UsersController < ApplicationController
  include SessionAction
  skip_before_action :authenticated, only: [:new, :create]
  layout "user_sessions_layout"

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      session[:user_id] = @user.id
      return redirect_to tasks_path
    else
      render :new
    end
  end

  def update
    if @current_user.update(user_update_params)
      render json: @current_user.to_json(except: :password_digest)
    else
      render json: { error: @current_user.errors }, status: 501
    end
  end

  def destroy

  end

  private

  def user_params
    params.require(:user).permit(:name, :password, :email)
  end

  def user_update_params
    params.require(:user).permit(:name, :email)
  end
end
