class UsersController < ApplicationController
  include SessionAction
  skip_before_action :authenticated
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

  private

  def user_params
    params.require(:user).permit(:name, :password, :email, :deleted_at)
  end
end
