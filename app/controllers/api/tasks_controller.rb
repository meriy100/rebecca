class Api::TasksController < ApiController
  include TasksAction
  before_action :set_task, only: [:done, :update, :destroy]

  # GET
  # api/tasks
  def index
    @tasks = Task.on_user
    # @user = User.where(name: current_user)
    # @user = :current_user
  end

  # POST api/tasks
  # 期待されるparams = {
  #   tasks: {
  #     user_id: int, title: string,
  #     id_done: false, weight: int,
  #     deadline_at: "yyyy-mm-dd HH:MM:SS"
  #   }
  # }
  def create
    @task = Task.new(task_params)
    if @task.save
      render json: @task
    else
      render json: { create: false }
    end
  end

  # POST
  # api/tasks/:sync_token
  def done
    if @task.done
      render json: @task
    else
      render json: { done: false }
    end
  end

  # PATCH
  # api/tasks/:sync_token
  # 期待されるparams = {
  #   tasks:{
  #     変更されるカラム: 値
  #   }
  # }
  def update
    if @task.update(task_params)
      render json: @task
    else
      render json: { update: false }
    end
  end

  # DELETE
  # api/tasks/:sync_token
  def destroy
    @task.destroy
    respond_to do |format|
      format.json { head :no_content }
    end
  end

  # POST
  # api/tasks/:sync_token
  # 期待されるparams = {
  #   tasks: [
  #     {user_id: int, sync_token: string,
  #      title: string, id_done: false,
  #      weight: int, deadline_at: "yyyy-mm-dd HH:MM:SS",
  #      updated_at: "yyyy-mm-dd HH:MM:SS"},
  #     {...},
  #     {...},
  #     ....
  #     {...}
  #   ]
  # }
  def sync
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
    redirect_to api_tasks_path
  end

  private

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
    @task = Task.on_user.find_by(sync_token: params[:sync_token])
  end
end
