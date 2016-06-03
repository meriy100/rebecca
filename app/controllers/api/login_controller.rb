class Api::LoginController < ApiController
  skip_before_filter :authenticated
 

  def login
    user = User.find_by(name: params[:login_user])
    if user && user.authenticate(params[:password]) then
      session[:user_id] = user.id
      return redirect_to api_tasks_path
    end
    render 'index'
   end

  def logout
    reset_session
    return redirect_to login_path
  end

  def sign_up
    @user = User.new
  end

  def create_user
    @user = User.new(user_params)
    if @user.save
      session[:user_id] = @user.id
      return redirect_to top_path
    else
      render :sign_up
    end
  end
  private
    def user_params
      params.require(:user).permit(:name, :password, :email, :deleted_at)
    end
end
