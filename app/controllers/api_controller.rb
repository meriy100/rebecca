class ApiController < ActionController::Base
  protect_from_forgery with: :exception
  before_filter :authenticated

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
