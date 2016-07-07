class UserSessionsController < ApplicationController
  include SessionAction
  skip_before_action :authenticated
  layout "user_sessions_layout"

  def new
    redirect_to tasks_path if current_user
    @user = User.new
  end

  def create
    @user = if User.email?(user_params[:email_or_name])
              User.find_by(email: user_params[:email_or_name])
            else
              User.find_by(name: user_params[:email_or_name])
            end
    if @user && @user.authenticate(user_params[:password])
      session[:user_id] = @user.id
      return redirect_to tasks_path
    end
    @user = User.new user_params
    render :new
  end

  def destroy
    User.reset_current_user
    reset_session
    redirect_to top_path
  end

  private

  def user_params
    params.require(:user).permit(:password, :email_or_name)
  end
end
