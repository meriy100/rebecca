class Api::LoginController < ApiController
  skip_before_filter :authenticated

  def login
    user = User.find_by(name: params[:login_user])
    if user && user.authenticate(params[:password])
      session[:user_id] = user.id
      return redirect_to api_tasks_path
    end
    render :index
  end

  def logout
    reset_session
    redirect_to login_path
  end

  def sign_up
    @user = User.new
  end

  def create_user
    @user = User.new(user_params)
    if @user.save
      session[:user_id] = @user.id
      return redirect_to api_tasks_path
    else
      return redirect_to api_create_user_path
    end
  end

  private

  def user_params
    params.require(:user).permit(:name, :password, :email, :deleted_at)
  end
end
