class UserSessionsController < ApplicationController
  include SessionAction
  skip_before_action :authenticated
  layout "user_sessions_layout"

  def new
    @user = User.new
  end

  def create
    @user = if User.is_email?(user_params[:email_or_name])
             User.find_by(email: user_params[:email_or_name])
           else
             User.find_by(name: user_params[:email_or_name])
           end
    if @user && @user.authenticate(user_params[:password])
      session[:user_id] = @user.id
      return redirect_to top_path
    end
    @user = User.new
    render :new
  end

  def destroy
    reset_session
    redirect_to new_user_session_path
  end

  private

  def user_params
    params.require(:user).permit(:password, :email_or_name)
  end
end
