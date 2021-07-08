class ApiController < ActionController::Base
  # protect_from_forgery with: :null_session
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
    render json: { errors: "session faild" }, status: 501 unless @current_user
  end

  def current_user
    User.current_user
  end
end
