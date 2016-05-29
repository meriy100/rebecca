class TasksController < ApplicationController
  before_action :set_task, only: [:show, :edit, :update, :destroy, :done]

  def index
    @tasks = Task.where(user: current_user, status: Task::DOING)
  end

  def doned
    @tasks = Task.where(user: current_user, status: Task::DONE)
  end

  def show
  end

  def new
    @task = Task.new
  end

  def edit
  end

  def done
    if @task.done
      redirect_to tasks_path
    else
      redirect_to tasks_path
    end
  end

  def create
    @task = Task.new(task_params)
    if @task.save
      @tasks = Task.where(user: current_user, status: Task::DOING)
    else
      render :new
    end
  end

  def update
    @task.update(params["atr"] => params["value"])
    head  200
  end

  def destroy
    @task.destroy
    respond_to do |format|
      format.html { redirect_to tasks_url, notice: 'Task was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    def set_task
      @task = Task.where(user: current_user).find(params[:id])
    end

    def task_params
      params.require(:task).permit(:user_id, :name, :status, :weight, :deadline_at, :deleted_at)
    end
end
