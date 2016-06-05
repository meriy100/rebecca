class Api::TasksController < ApiController
  def index
    @tasks = Task.where(user: current_user, is_done: false)
    # @user = User.where(name: current_user)
    # @user = :current_user
  end
end
