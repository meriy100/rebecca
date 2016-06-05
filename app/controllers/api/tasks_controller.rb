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
            same_task = tasks.find_by(sync_token: ios_task[:sync_token])
            if same_task.present?
                if Time.zone.parse(ios_task[:updated_at]) > same_task.updated_at
                    same_task.update(name: ios_task[:name], status: ios_task[:status], weight: ios_task[:weight], deadline_at: Time.zone.parse(ios_task[:deadline_at]), updated_at: Time.zone.parse(ios_task[:updated_at]))
                end
            else
                Task.create(user_id: ios_task[:user_id], sync_token: ios_task[:sync_token], name: ios_task[:name], status: ios_task[:status], weight: ios_task[:weight], deadline_at: Time.zone.parse(ios_task[:deadline_at]),  created_at: Time.zone.parse(ios_task[:created_at]), updated_at: Time.zone.parse(ios_task[:updated_at]))
            end
        end
    end
    redirect_to api_tasks_path
  end

end

