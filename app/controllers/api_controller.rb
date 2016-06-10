class ApiController < ActionController::Base
  # protect_from_forgery with: :null_session
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
<<<<<<< 002f53a47b0e2ab02d6bc2c9326baa28a7e6ba3b
    render json: { errors: "session faild" } unless @current_user
=======
    render json: {errors: "session faild"} unless @current_user
>>>>>>> api session response
  end

  def current_user
    User.current_user
  end
end
