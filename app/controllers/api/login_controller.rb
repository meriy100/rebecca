class Api::LoginController < ApiController
  skip_before_filter :authenticated

  def login
    user = User.find_by(name: params[:login_user])
    if user && user.authenticate(params[:password])
      session[:user_id] = user.id
      return redirect_to api_tasks_path
    end
    render json: { errors: "login faild" }
  end

  def logout
    reset_session
    render json: { message: "success" }
  end

  def create_user
    @user = User.new(user_params)
    if @user.save
      session[:user_id] = @user.id
      return redirect_to api_tasks_path
    else
      render json: { errors: @user.errors.full_messages }
    end
  end

  private

  def user_params
    params.require(:user).permit(:name, :password, :email, :deleted_at)
  end
end
