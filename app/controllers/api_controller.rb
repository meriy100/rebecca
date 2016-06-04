class ApiController < ActionController::Base
  protect_from_forgery with: :exception
  before_action :set_user
  before_filter :authenticated

  def authenticated
    if session[:user_id]
      begin
        @user = User.find(session[:user_id])
        User.current_user = @user
      rescue ActiveRecord::RecordNotFound
        reset_session
      end
    end
    redirect_to login_path unless @current_user
  end
  def set_user
    @current_user = User.find session[:user_id]
  end

  def current_user
    @current_user
  end
end
