class Api::TasksController < ApiController
  def index
    @tasks = Task.where(user: current_user, status: Task::DOING)
    # @user = User.where(name: current_user)
    # @user = :current_user
  end
end
