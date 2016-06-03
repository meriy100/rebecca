class Api::TasksController < ApiController
  def index
    @tasks = Task.where(user: current_user, status: Task::DOING)
  end
end
