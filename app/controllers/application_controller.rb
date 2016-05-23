class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  before_action :set_user
  before_filter :authenticated
  def index
    redirect_to expense_items_path
  end
  def authenticated
    if session[:user_id]
      begin
        @user = User.find_by(id: session[:user_id])
        Thread.current[:user_id] = session[:user_id]
      rescue ActiveRecord::RecordNotFound
        reset_session
      end
    end
    redirect_to login_path unless @current_user
  end
  def set_user
    @current_user = session[:user_id]
  end

  def current_user
    @current_user
  end
end
