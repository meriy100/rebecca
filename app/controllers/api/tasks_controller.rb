class Api::TasksController < ApiController
  def index
    @tasks = Task.where(user: current_user, status: Task::DOING)
    # @user = User.where(name: current_user)
    # @user = :current_user
  end

  def sync
    tasks = Task.where(user: current_user, status: Task::DOING)
    params.each |ios_task|
        if ios_task[:sync_token].present?
            @same_task = tasks.find_by(sync_token: ios_task[:sync_token])
            if @same_task.present?
                if ios_task.updated_at > same_task.updated_at
                    @same_task.update(ios_task)
                end
            end
        end
    end
    redirect_to api_tasks_path
  end

end
