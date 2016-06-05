class Api::TasksController < ApiController
  include TasksAction
  before_action :set_task, only: [:done, :update, :destroy]
  def index
    @tasks = Task.where(user: current_user)
    # @user = User.where(name: current_user)
    # @user = :current_user
  end

  def create
    @task = Task.new(task_params)
    if @task.save
      render json: @task
    else
      render json: {create: false}
    end
  end

  def done
    if @task.done
      render json: @task
    else
      render json: {done: false}
    end
  end

  def update
    if @task.update(task_params)
      render json: @task
    else
      render json: {update: false}
    end
  end

  def destroy
    @task.destroy
    respond_to do |format|
      format.json { head :no_content }
    end
  end

  def sync
    tasks = Task.where(user: current_user)
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
      title: task_params[:title],
      is_done: task_params[:is_done],
      weight: task_params[:weight],
      deadline_at: Time.zone.parse(task_params[:deadline_at]),
      created_at: Time.zone.parse(task_params[:created_at]),
      updated_at: Time.zone.parse(task_params[:updated_at])
    }
  end

  def set_task
    @task = Task.find_by(user: current_user, sync_token: params[:sync_token])
  end
end

