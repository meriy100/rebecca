class Api::TasksController < ApiController
  include TasksAction
  before_action :set_task, only: [:done, :update, :destroy]

  # GET
  def index
    @tasks = Task.on_user
  end

  # POST api/tasks
  def create
    @task = Task.new(task_params)
    @task.save
    render :task
  end

  # POST
  def done
    @task.done
    render :task
  end

  # PATCH
  def update
    @task.update(task_params)
    render :task
  end

  # DELETE
  def destroy
    @task.destroy
    respond_to do |format|
      format.json { head :no_content }
    end
  end

  # POST
  def sync
    @message = if Time.zone.parse(params[:user][:task_updated_at]) > Time.zone.parse(params[:user][:synced_at])
                 full_sync
                 @tasks = Task.on_user
                 "full_sync"
               elsif current_user.task_updated_at > Time.zone.parse(params[:user][:task_updated_at])
                 @tasks = Task.on_user
                 "sync"
               else
                 render json: { errors: "no_sync" }, status: 300
               end
  end

  private

  def full_sync
    tasks = Task.on_user
    params[:tasks].each do |ios_task|
      tasks.find_by(sync_token: ios_task[:sync_token]).tap do |sync_task|
        if sync_task
          if Time.zone.parse(ios_task[:updated_at]) > sync_task.updated_at
            sync_task.update(sync_params(ios_task))
          end
        else
          Task.create(sync_params(ios_task))
        end
      end
    end
  end

  def sync_params(task_params = {})
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
    @task = Task.on_user.find_by(sync_token: params[:sync_token]) || Task.create(task_params)
  end
end
