class Api::TasksController < ApiController
  def index
    @tasks = Task.where(user: current_user, status: Task::DOING)
    # @user = User.where(name: current_user)
    # @user = :current_user
  end

  def sync
    tasks = Task.where(user: current_user, status: Task::DOING)
    params[:tasks].each do |ios_task|
        if ios_task[:sync_token].present?
            if sync_task = tasks.find_by(sync_token: ios_task[:sync_token]).presence
              if Time.zone.parse(ios_task[:updated_at]) > sync_task.updated_at
                  sync_task.update(sync_params(ios_task))
              end
            else
                Task.create(sync_params(ios_task))
            end
        end
    end
    redirect_to api_tasks_path
  end

  private

  def sync_params task_params = {}
    {
      user_id: task_params[:user_id],
      sync_token: task_params[:sync_token],
      name: task_params[:name],
      status: task_params[:status],
      weight: task_params[:weight],
      deadline_at: Time.zone.parse(task_params[:deadline_at]),
      created_at: Time.zone.parse(task_params[:created_at]),
      updated_at: Time.zone.parse(task_params[:updated_at])
    }
  end
end

