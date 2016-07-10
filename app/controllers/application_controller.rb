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
        User.reset_current_user
        reset_session
      end
    end
    redirect_to new_user_session_path unless @current_user
  end

  def current_user
    User.current_user || set_current_user
  end

  private

  def set_current_user
    if session[:user_id]
      current_user = User.find(session[:user_id])
      User.current_user = current_user
    end
  rescue ActiveRecord::RecordNotFound
    User.reset_current_user
    reset_session
  end

  def set_events
    @events = Event.on_user.order(date: :asc).limit(10)
  end

  def set_new_task
    @task = Task.new
  end

  def set_search
    @search = Task.search(params[:q])
  end
end
