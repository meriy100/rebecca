class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  before_action :authenticated

  def authenticated
    if session[:user_id]
      begin
        @current_user = User.find(session[:user_id])
        User.current_user = @current_user
      rescue ActiveRecord::RecordNotFound
        reset_session
      end
    end
    redirect_to login_path unless @current_user
  end

  def current_user
    User.current_user
  end
end
